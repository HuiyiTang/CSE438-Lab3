//
//  ViewController.swift
//  HUIYI TANG-Lab3
//
//  Created by Huiyi Tang on 10/1/21.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var redColor: UIButton!
    @IBOutlet weak var orangeColor: UIButton!
    @IBOutlet weak var yellowColor: UIButton!
    @IBOutlet weak var greenColor: UIButton!
    @IBOutlet weak var purpleColor: UIButton!
    @IBOutlet weak var blueColor: UIButton!
    @IBOutlet weak var shapeSelect: UISegmentedControl!
    @IBOutlet weak var actionSelect: UISegmentedControl!
    @IBOutlet weak var shapeCanvas: DrawingView!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var bgColor: UIBarButtonItem!
    @IBOutlet weak var opacityChange: UISlider!
    @IBOutlet var pinchAction: UIPinchGestureRecognizer!
    @IBOutlet var rotateAction: UIRotationGestureRecognizer!
    
    var currentShape: Shape?
    var colorSelect: UIColor = UIColor.red
    var shapeFlag: Int = 1
    var actionFlag: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "CSE 438 Drawing App"
        shapeCanvas.backgroundColor = UIColor.white
        
        redColor.layer.cornerRadius = redColor.frame.width / 2
        orangeColor.layer.cornerRadius = orangeColor.frame.width / 2
        yellowColor.layer.cornerRadius = yellowColor.frame.width / 2
        greenColor.layer.cornerRadius = greenColor.frame.width / 2
        blueColor.layer.cornerRadius = blueColor.frame.width / 2
        purpleColor.layer.cornerRadius = purpleColor.frame.width / 2
        
        rotateAction.delegate = self
        pinchAction.delegate = self
    }
    
    @IBAction func bgColorChange(_ sender: Any) {
        if shapeCanvas.backgroundColor == UIColor.gray {
            shapeCanvas.backgroundColor = UIColor.white
        }
        else {
            shapeCanvas.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func sliderChange(_ sender: Any) {
        for item in shapeCanvas.items {
            (item as? Shape)!.opacity = CGFloat(opacityChange.value)
        }
        
        shapeCanvas.setNeedsDisplay()
    }
    
    @objc func imageSaved(image: UIImage!, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?) {
                    if (error != nil) {
                        print("error")
                    }
        /*
         Cite:https://stackoverflow.com/questions/40980863/how-can-i-save-a-picture-in-the-photo-library-swift?rq=1
         */
                }
    
    @IBAction func photoCreate(_ sender: Any) {
        let myView = shapeCanvas
        let image = UIImage(view: myView!)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {true}
    
    @IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        if actionFlag != 2 {
            return
        }
        
        let touchPoint = sender.location(in: shapeCanvas)
        let currentShape = shapeCanvas.itemAtLocation(touchPoint) as? Shape
        currentShape?.size *= sender.scale
        shapeCanvas.setNeedsDisplay()
    }
    
    @IBAction func rotateGesture(_ sender: UIRotationGestureRecognizer) {
        if actionFlag != 2 {
            return
        }
        
        let touchPoint = sender.location(in: shapeCanvas)
        let currentShape = shapeCanvas.itemAtLocation(touchPoint) as? Shape
        currentShape?.rotate = sender.rotation
        shapeCanvas.setNeedsDisplay()
    }
    
    @IBAction func shapeControl(_ sender: Any) {
        switch shapeSelect.selectedSegmentIndex {
        case 0: shapeFlag = 1;
        case 1: shapeFlag = 2;
        case 2: shapeFlag = 3;
        default: break
        }
    }
    
    @IBAction func actionControl(_ sender: Any) {
        switch actionSelect.selectedSegmentIndex {
        case 0: actionFlag = 1;
        case 1: actionFlag = 2;
        case 2: actionFlag = 3;
        default: break
        }
    }
    
    @IBAction func redSelect(_ sender: Any) {
        colorSelect = UIColor.red
    }
    
    @IBAction func orangeSelect(_ sender: Any) {
        colorSelect = UIColor.orange
    }
    
    @IBAction func yellowSelect(_ sender: Any) {
        colorSelect = UIColor.yellow
    }
    
    @IBAction func greenSelect(_ sender: Any) {
        colorSelect = UIColor.green
    }
    
    @IBAction func blueSelect(_ sender: Any) {
        colorSelect = UIColor.blue
    }
    
    @IBAction func purpleSelect(_ sender: Any) {
        colorSelect = UIColor.purple
    }
    
    @IBAction func clearStuff(_ sender: Any) {
        shapeCanvas.items = []
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
              let touchPoint = touches.first?.location(in: shapeCanvas)
        else { return }
        
        if shapeFlag == 1 && actionFlag == 1 {
            currentShape = currentShape as? Square
            currentShape = Square(origin: touchPoint, color: colorSelect)

        }
        else if shapeFlag == 2 && actionFlag == 1  {
            currentShape = currentShape as? Circle
            currentShape = Circle(origin: touchPoint, color: colorSelect)
        }
        else if shapeFlag == 3 && actionFlag == 1  {
            currentShape = currentShape as? Triangle
            currentShape = Triangle(origin: touchPoint, color: colorSelect)
        }
        
        
        if actionFlag == 3 {
            currentShape = shapeCanvas.itemAtLocation(touchPoint) as? Shape
            if ((currentShape?.contains(point: touchPoint)) != nil) {
                let index = shapeCanvas.items.firstIndex{$0 === currentShape}!
                shapeCanvas.items.remove(at: index)
            }
            else {
                print("Shape not selected!")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
              let touchPoint = touches.first?.location(in: shapeCanvas)
        else { return }
        
        if actionFlag == 2 {
            currentShape = shapeCanvas.itemAtLocation(touchPoint) as? Shape
            currentShape?.origin = touchPoint
            shapeCanvas.setNeedsDisplay()
        }
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if actionFlag == 1{
            if let newShape = currentShape {
                shapeCanvas.items.append(newShape)
            }
        }
    }

}

extension UIImage{
    convenience init(view: UIView) {

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(cgImage: (image?.cgImage)!)
    /*
         Cite:https://stackoverflow.com/questions/40980863/how-can-i-save-a-picture-in-the-photo-library-swift?rq=1
    */
  }
}

extension UIBezierPath {
    func rotate(by angleRadians: CGFloat){
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: angleRadians)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        self.apply(transform)
    }
}
