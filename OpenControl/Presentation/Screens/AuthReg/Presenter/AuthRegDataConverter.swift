//
//  AuthRegDataConverter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol AuthRegDataConverterInput {
    func convert(with model: [AuthRegData], segmentedValue: Int, delegate: AnyObject) -> AuthRegViewModel
}

final class AuthRegDataConverter {
    
    private typealias Row = AuthRegViewModel.Section.Row
    private typealias Section = AuthRegViewModel.Section
    
    private typealias LogoConfigurator = TableCellConfigurator<
        LogoTVCell,
        LogoTVCell.Model
    >
    private typealias SegmentedConfigurator = TableCellConfigurator<
        SegmentedControllTVCell,
        SegmentedControllTVCell.Model
    >
    private typealias TextFieldConfigurator = TableCellConfigurator<
        TextFieldTVCell,
        TextFieldTVCell.Model
    >
    private typealias ButtonConfigurator = TableCellConfigurator<
        ButtonTVCell,
        ButtonTVCell.Model
    >
    private typealias ForgotPasswordConfigurator = TableCellConfigurator<
        ForgotPasswordTVCell,
        ForgotPasswordTVCell.Model
    >
    private typealias FaceIdConfigurator = TableCellConfigurator<
        FaceIdTVCell,
        FaceIdTVCell.Model
    >
    private typealias SocialsConfigurator = TableCellConfigurator<
        SocialsTVCell,
        SocialsTVCell.Model
    >
    private typealias PassRulesConfigurator = TableCellConfigurator<
        PassRulesTVCell,
        PassRulesTVCell.Model
    >
    private typealias CheckBoxConfigurator = TableCellConfigurator<
        CheckBoxTVCell,
        CheckBoxTVCell.Model
    >
    
    private func assembleLogo() -> Section {
        
        var rows: [Row] = []
        
        typealias LogoModel = LogoTVCell.Model
        let logoModel = LogoModel()
        let logoConfigurator = LogoConfigurator(item: logoModel)
        let cell = Row(configurator: logoConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assembleSegmented(segmentedValue: Int, delegate: AnyObject) -> Section {
        
        var rows: [Row] = []
        
        typealias SegmentedModel = SegmentedControllTVCell.Model
        let segmentedModel = SegmentedModel(
            delegate: delegate as? SegmentedControllTVCellDelegate,
            segmentedValue: segmentedValue
        )
        let segmentedConfigurator = SegmentedConfigurator(item: segmentedModel)
        let cell = Row(configurator: segmentedConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assembleTextFields(with model: AuthRegData, delegate: AnyObject) -> Section {
        
        var rows: [Row] = []
        
        typealias TextFieldModel = TextFieldTVCell.Model
        let textFieldModel = TextFieldModel(authRegData: model, delegate: delegate as? TextFieldTVCellDelegate)
        let textFieldConfigurator = TextFieldConfigurator(item: textFieldModel)
        let cell = Row(configurator: textFieldConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assembleButton(with title: String, delegate: AnyObject) -> Section {
        
        var rows: [Row] = []
        
        typealias ButtonModel = ButtonTVCell.Model
        let buttonModel = ButtonModel(title: title, delegate: delegate as? ButtonTVCellDelegate)
        let buttonConfigurator = ButtonConfigurator(item: buttonModel)
        let cell = Row(configurator: buttonConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assembleForgotPassword() -> Section {
        
        var rows: [Row] = []
        
        typealias ForgotPasswordModel = ForgotPasswordTVCell.Model
        let forgotPasswordModel = ForgotPasswordModel()
        let forgotPasswordConfigurator = ForgotPasswordConfigurator(item: forgotPasswordModel)
        let cell = Row(configurator: forgotPasswordConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assembleFaceId() -> Section {
        
        var rows: [Row] = []
        
        typealias FaceIdModel = FaceIdTVCell.Model
        let faceIdModel = FaceIdModel()
        let faceIdConfigurator = FaceIdConfigurator(item: faceIdModel)
        let cell = Row(configurator: faceIdConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assembleSocials() -> Section {
        
        var rows: [Row] = []
        
        typealias SocialsModel = SocialsTVCell.Model
        let socialsModel = SocialsModel(socialMediaModel: [
            .init(icon: R.image.vkIcon(), name: .vk),
            .init(icon: R.image.tgIcon(), name: .tg),
            .init(icon: R.image.okIcon(), name: .ok),
            .init(icon: R.image.gosusIcon(), name: .gosus),
            .init(icon: R.image.plusIcon(), name: .plus)
        ])
        let socialsConfigurator = SocialsConfigurator(item: socialsModel)
        let cell = Row(configurator: socialsConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assemblePassRules() -> Section {
        
        var rows: [Row] = []
        
        typealias PassRulesModel = PassRulesTVCell.Model
        let passRulesModel = PassRulesModel()
        let passRulesConfigurator = PassRulesConfigurator(item: passRulesModel)
        let cell = Row(configurator: passRulesConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
    
    private func assembleCheckBox() -> Section {
        
        var rows: [Row] = []
        
        typealias CheckBoxModel = CheckBoxTVCell.Model
        let checkBoxModel = CheckBoxModel()
        let checkBoxConfigurator = CheckBoxConfigurator(item: checkBoxModel)
        let cell = Row(configurator: checkBoxConfigurator)
        rows.append(cell)
        
        return Section(rows: rows)
    }
}

extension AuthRegDataConverter: AuthRegDataConverterInput {

    func convert(with model: [AuthRegData], segmentedValue: Int, delegate: AnyObject) -> AuthRegViewModel {
        
        var sections: [Section] = []
        
        let logoSection = assembleLogo()
        sections.append(logoSection)
        
        let segmentedSection = assembleSegmented(segmentedValue: segmentedValue, delegate: delegate)
        sections.append(segmentedSection)
        
        for data in model {
            let textFieldSection = assembleTextFields(with: data, delegate: delegate)
            sections.append(textFieldSection)
        }
        
        if segmentedValue == 0 {
            
            let passRulesSection = assemblePassRules()
            sections.append(passRulesSection)
            
            let checkBoxSection = assembleCheckBox()
            sections.append(checkBoxSection)
            
            let buttonSection = assembleButton(with: "Зарегистрироваться", delegate: delegate)
            sections.append(buttonSection)
            
        } else {
            
            let buttonSection = assembleButton(with: "Войти", delegate: delegate)
            sections.append(buttonSection)
            
            let forgotSection = assembleForgotPassword()
            sections.append(forgotSection)
            
            let faceIdSection = assembleFaceId()
            sections.append(faceIdSection)
            
            let socialsSection = assembleSocials()
            sections.append(socialsSection)
        }
        
        return AuthRegViewModel(sections: sections)
    }
}
