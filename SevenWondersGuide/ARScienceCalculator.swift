//
//  ARScienceCalculator.swift
//  SevenWondersGuide
//
//  Created by Johnnan Monzon on 10/20/20.
//

import SwiftUI
import ARKit

enum ResetState {
    case Start
    case Reset
    case End
    case Null
}

enum Symbol : String
{
    case wheel
    case compass
    case tablet
    case wild
    case null
}

protocol ARScienceCalculatorDelegate {
    func onCardRecognized(name: String)
    func onResetStart()
    func onResetEnd()
}

struct ARScienceCalculator: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, ARScienceCalculatorDelegate {
        
        var parent: ARScienceCalculator
        
        init(_ parent: ARScienceCalculator){
            self.parent = parent
        }
        
        func onCardRecognized(name: String) {
            
            let symbol = getSymbol(name: name)
            
            if symbol == Symbol.wild {
                print(name)
                parent.wildCount += 1
            } else {
                parent.symbolCount[symbol]! += 1
            }

            parent.points = calculatePoints(symbolCount: parent.symbolCount, wildCount: parent.wildCount)
        }
        
        func getSymbol(name: String) -> Symbol {
            switch name {
            case "workshop":
                return Symbol.wheel
            case "laboratory":
                return Symbol.wheel
            case "observatory":
                return Symbol.wheel
            case "study":
                return Symbol.wheel
            case "apothecary":
                return Symbol.compass
            case "dispensary":
                return Symbol.compass
            case "lodge":
                return Symbol.compass
            case "academy":
                return Symbol.compass
            case "scriptorium":
                return Symbol.tablet
            case "library":
                return Symbol.tablet
            case "school":
                return Symbol.tablet
            case "university":
                return Symbol.tablet
            case "scientistsguild":
                return Symbol.wild
            case "babylonwonder":
                return Symbol.wild
            default:
                return Symbol.null
            }
        }
        
        func onResetStart() {
            parent.points = 0
            parent.symbolCount = [Symbol.wheel: 0, Symbol.compass: 0, Symbol.tablet: 0]
            parent.wildCount = 0
            parent.reset = ResetState.Reset
        }
        
        func onResetEnd() {
            parent.reset = ResetState.End
        }
        
        func calculatePoints(symbolCount: [Symbol : Int], wildCount: Int) -> Int {
            
            var finalScore = 0
            
            let combinations = Combinatorics.combinationsWithRepetitionFrom(Array(symbolCount.keys), taking: wildCount)
            
            for comb in combinations {
                
                var tempSymbolCount = symbolCount
                
                for symbol in comb {
                    tempSymbolCount[symbol]! += 1
                }
                
                var points = 0
                var leastSymbolCount = 999
                
                for (_, count) in tempSymbolCount {
                                  
                    points += count * count

                    if count < leastSymbolCount {
                        leastSymbolCount = count
                    }
                }

                points += leastSymbolCount * 7
                
                if points > finalScore {
                    finalScore = points
                }
            }

            return finalScore
        }
    }
    
    @Binding var points: Int
    @Binding var reset: ResetState
    @Binding var symbolCount: [Symbol : Int]
    @Binding var wildCount: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ARScienceCalculatorController {
        let calculator = ARScienceCalculatorController()
        calculator.delegate = context.coordinator
        return calculator
    }
    
    func updateUIViewController(_ uiViewController: ARScienceCalculatorController, context: UIViewControllerRepresentableContext<ARScienceCalculator>) {
        if(reset == ResetState.Start) {
            uiViewController.onResetButtonClicked()
        }
    }
}

class ARScienceCalculatorController: UIViewController, ARSCNViewDelegate {

    var delegate: ARScienceCalculatorDelegate?
    
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        let images = ARReferenceImage.referenceImages(inGroupNamed: "Science", bundle: nil)
        configuration.trackingImages = images!
        arView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        
        let referenceImage = imageAnchor.referenceImage
        let name = imageAnchor.referenceImage.name!
                
        delegate?.onCardRecognized(name: name)

        DispatchQueue.main.async {
            
            let image = UIImage(named: "checkmark")
            let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                             height: referenceImage.physicalSize.width)
            let imageNode = SCNNode(geometry: plane)
            imageNode.geometry?.firstMaterial?.diffuse.contents = image
            imageNode.eulerAngles.x = -.pi / 2
            imageNode.runAction(self.imageHighlightAction)

            node.addChildNode(imageNode)
        }
    }
    
    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOut(duration: 0.5),
            .removeFromParentNode()
            
        ])
    }
    
    func onResetButtonClicked() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
            self.delegate?.onResetStart()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            
            if let anchors = self.arView.session.currentFrame?.anchors {
                for anchor in anchors {
                    self.arView.session.remove(anchor: anchor)
                }
            }
            self.delegate?.onResetEnd()
        }
    }
}
