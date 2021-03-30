//
//  Extension.swift
//  VisualNovel
//
//  Created by Daniil Zavodchanovich on 29.03.2021.
//

import Foundation
import UIKit


extension UITextField {
    func setTextFieldAppearance(placeholder: String, fontSize: CGFloat){
        self.placeholder = placeholder
        self.font = UIFont(name:"roboto", size: fontSize)
        
        self.borderStyle = .none
        self.backgroundColor = UIColor(named: "LightGrayColor")
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.returnKeyType = .done
        self.clearButtonMode = .whileEditing
        self.contentHorizontalAlignment = .leading
        self.contentVerticalAlignment = .center
    }
}

extension UILabel {
    func setLabelAppearance(text: String, color: String, fontSize: CGFloat, superLabel: Bool = false){
        layer.backgroundColor = UIColor(named: color)?.cgColor
        self.text = text
        
        self.font = (superLabel) ? UIFont(name:"quattrocento", size: fontSize) : UIFont(name:"roboto", size: fontSize)
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.numberOfLines = (superLabel) ? 3 : 1
    }
}

extension UIButton {
    func setButtonAppearance(text: String, color: String, fontSize: CGFloat){
        layer.backgroundColor = UIColor(named: color)?.cgColor
        titleLabel?.font = UIFont(name:"roboto", size: fontSize)
        
        setTitle(text, for: .normal)
        setTitleColor(UIColor.lightText, for: .highlighted)
        

    }
    func setButtonTarget(target: Scene){
        self.tag = target.rawValue
        self.addTarget(self, action: Selector(("buttonClicked")), for: .touchUpInside)
    }
}

extension UIViewController{
    var screenSize: CGRect {
        get
        {return UIScreen.main.bounds}
    }
    
    func setUpScene(data: ViewControllerData){
        setBackgroundImage(backgroundImageName: data.backgroundImageName, additionalImageName: data.additionalImageName)
        switch data.sceneType
        {
        case .Main:
            setLabelAndButton(label: data.label, button: data.buttons[0])
        case .Input:
            setTextFieldWithLabelAndButton(label: data.label, fieldPlaceholder: data.textFieldPlaceholder, button: data.buttons[0])
        case .Choice:
            setLabelAndButtons(label: data.label, buttons: data.buttons)
        }
        
    }
    
    
    private func setBackgroundImage(backgroundImageName: String, additionalImageName: String?){
        let backgroundImage = UIImageView(frame: screenSize)
        backgroundImage.image = UIImage(named: backgroundImageName)
        backgroundImage.contentMode = .scaleToFill
        self.view.addSubview(backgroundImage)
        
        guard let safeAdditionalImageName = additionalImageName else {
            return
        }
        let additionalImage = UIImageView(frame: CGRect(x:0, y:0, width: screenSize.width/2, height: screenSize.height))
        additionalImage.image = UIImage(named: safeAdditionalImageName)
        additionalImage.contentMode = .scaleToFill
        additionalImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(additionalImage)
        
    }
    
    private func setTextFieldWithLabelAndButton(label: LabelInfo, fieldPlaceholder: String?, button: ButtonInfo){
            let labelHeight =
                (screenSize.midY / 8.0)

            let UIlabel = UILabel(frame: CGRect(x: 0, y: screenSize.midY + labelHeight, width: screenSize.width, height: labelHeight))
            UIlabel.setLabelAppearance(text: label.Text, color: label.Color, fontSize: labelHeight/2)
            self.view.addSubview(UIlabel)

            var currY = screenSize.midY + (screenSize.midY - labelHeight * 2)/2

            let UItextField = UITextField(frame: CGRect(x:0, y:currY, width: screenSize.width, height: labelHeight*2)
            )
        UItextField.setTextFieldAppearance(placeholder: fieldPlaceholder ?? "Введите текст...", fontSize: labelHeight/2 - 1)

            self.view.addSubview(UItextField)

            currY += labelHeight * 2.5

            let UIbutton = UIButton(frame: CGRect(x: 0, y: currY, width: screenSize.width, height: labelHeight))
            UIbutton.setButtonAppearance(text: button.Text, color: button.Color, fontSize: labelHeight/2)
        UIbutton.setButtonTarget(target: button.Segue)
            self.view.addSubview(UIbutton)



        }
    
    private func setLabelAndButton(label: LabelInfo, button: ButtonInfo){
        let buttonHeight =
            (screenSize.midY / 8.0)
        
        let labelHeight =
            (screenSize.midY / 2.5)
        
        let UIlabel = UILabel(frame: CGRect(x: 0, y: screenSize.midY - labelHeight, width: screenSize.width, height: labelHeight))
        UIlabel.setLabelAppearance(text: label.Text, color: label.Color, fontSize: labelHeight*0.28, superLabel: true)
        self.view.addSubview(UIlabel)
        
        
        let UIbutton = UIButton(frame: CGRect(x: 0, y: screenSize.midY + screenSize.midY/2 - buttonHeight/2, width: screenSize.width, height: buttonHeight))
        UIbutton.setButtonAppearance(text: button.Text, color: button.Color, fontSize: buttonHeight/2)
        UIbutton.setButtonTarget(target: button.Segue)
        self.view.addSubview(UIbutton)
        
        
        
    }
    
    private func setLabelAndButtons(label: LabelInfo, buttons: [ButtonInfo]){
        let buttonHeight =
            (((screenSize.midY / 8.0) * CGFloat(buttons.count + 2) * 2) <= screenSize.midY)
            ? (screenSize.midY / 8.0)
            : screenSize.midY / CGFloat((buttons.count * 2 + 2))
        
        let UIlabel = UILabel(frame: CGRect(x: 0, y: screenSize.midY + buttonHeight, width: screenSize.width, height: buttonHeight))
        UIlabel.setLabelAppearance(text: label.Text, color: label.Color, fontSize: buttonHeight/2)
        self.view.addSubview(UIlabel)
        
        var currY = screenSize.midY + (screenSize.midY + buttonHeight - CGFloat(buttons.count*2 - 2)*buttonHeight)/2
        
        for i in 0..<buttons.count{
            let button = UIButton(frame: CGRect(x: 0, y: currY, width: screenSize.width, height: buttonHeight))
            button.setButtonAppearance(text: buttons[i].Text, color: buttons[i].Color, fontSize: buttonHeight/2)
            button.setButtonTarget(target: buttons[i].Segue)
            self.view.addSubview(button)
            
            currY += buttonHeight*2
        }
    }
}
