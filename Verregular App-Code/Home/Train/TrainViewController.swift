//
//  TrainViewController.swift
//  Verregular App-Code
//
//  Created by Юлия Дегтярева on 2025-04-19.
//

import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    // Home work 2.8 - UILabel, который отображает номер текущего глагола из какого количества, напр.: "2/10" или "2 из 10"
    private lazy var currentVerbNumberLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        label.text = "\(count)/\(dataSource.count)"
        
        return label
        
    }()
    // Home work 2.8 - UILabel, показывает Score
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        label.text = "Score: \(count)"
        
        return label
        
    }()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()

    private lazy var checkButton = makeActionButton(withTitle: "Check".localized, action: #selector(checkAction))
    private lazy var skipButton = makeActionButton(withTitle: "Skip".localized, action: #selector(skipAction))
    
    // MARK: - Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
        return dataSource[count]
    }
    
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
            currentVerbNumberLabel.text = "\(count + 1)/\(dataSource.count)"
        }
    }
    
    // Home work - 1. свойство, которое будет считать очки пользователя. При каждом правильном ответе + 1 балл
    private var correctPointsCount = 0
    
    // Home work - 1. свойство, отвечающее можно ли начислять балл за вопрос
    private var canReceivePoint = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        setupUI()
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSource.first?.infinitive
        currentVerbNumberLabel.text = "1/\(dataSource.count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    // MARK: - Private methods
    
    /// Home work 2.8: Здесь объединяем одинаковый UI для кнопок skip и check
    @objc
    private func makeActionButton(withTitle title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    
    @objc
    private func checkAction() {
        // Home work - 1. свойство, которое будет считать очки пользователя. При каждом правильном ответе + 1 балл
        if checkAnswers() {
            if canReceivePoint {
                correctPointsCount += 1
            } else {
                checkButton.backgroundColor = .systemGray5
                checkButton.setTitle("Check".localized, for: .normal)
                correctPointsCount += 0
            }
            
            scoreLabel.text = "Score: \(correctPointsCount)"
            count += 1
            canReceivePoint = true // для следующего слова сбрасываем возможность получить балл
            
            // Проверка если последний глагол, показать алерт со скором
            if count >= dataSource.count {
                showResultsAlert()
            }
            
        } else {
            checkButton.backgroundColor = .red
            checkButton.setTitle("Try again".localized, for: .normal)
            canReceivePoint = false // после первой ошибки больше балл получить нельзя
        }
    }
    
    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() ==
            currentVerb?.pastSimple.lowercased() &&
        participleTextField.text?.lowercased() ==
        currentVerb?.participle.lowercased()
    }
    
    
    // Home Work 2.8 - добавить метод, который будет показывать UIAlertController с очками пользователя, если это был последний глагол из выбранных для изучения. У UIAlertController должна быть одна кнопка OK, по нажатию на которую возвращаемся на первый экран.
    private func showResultsAlert() {
        let alert = UIAlertController(title: "The training is over",
                                      message: "Yours score: \(correctPointsCount)/\(dataSource.count)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    @objc
    private func skipAction() {
        count += 1
        
        // если дошли до конца — показываем алерт
        if count >= dataSource.count {
            showResultsAlert()
            return
        }
        
        // сбрасываем тексты
        infinitiveLabel.text = currentVerb?.infinitive
        pastSimpleTextField.text = ""
        participleTextField.text = ""
        
        // обновляем счетчики на экране
        currentVerbNumberLabel.text = "\(count + 1)/\(dataSource.count)"
        
        // возвращаем кнопку Check в обычное состояние
        checkButton.backgroundColor = .systemGray5
        checkButton.setTitle("Check".localized, for: .normal)
        
        // можно разрешить получать балл на следующем слове
        canReceivePoint = true
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([
        currentVerbNumberLabel,
        scoreLabel,
        infinitiveLabel,
        pastSimpleLabel,
        pastSimpleTextField,
        participleLabel,
        participleTextField,
        checkButton,
        skipButton])
        
      setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        currentVerbNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(edgeInsets)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(60)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(100)
            make.leading.equalToSuperview().inset(edgeInsets)
            make.trailing.equalTo(skipButton.snp.leading).offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(skipButton)
        }

        skipButton.snp.makeConstraints { make in
            make.top.equalTo(checkButton)
            make.trailing.equalToSuperview().inset(edgeInsets)
            make.height.equalTo(checkButton)
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        }
        return true
    }
}


// MARK: - Keyboard events
// we do not subscribe to any delegate here because we simply separate the code about raising and hiding the keyboard from the main class
private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        scrollView.contentInset.bottom = frame.height + 50
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 50
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}





