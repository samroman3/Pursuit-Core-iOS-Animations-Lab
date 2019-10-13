
import UIKit

class ViewController: UIViewController {
    
//MARK: - VIEWS
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    //MARK: - Up and Down Stack
    lazy var buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 5
        return buttonStack
    }()
    
    lazy var upButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move down", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Left and Right Stack
    
    lazy var buttonStackViewLR: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 5
        return buttonStack
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move left", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move right", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Steppers
    lazy var animationStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2
        stepper.minimumValue = 0
        stepper.maximumValue = 5
        stepper.addTarget(self, action: #selector(animationStepperPressed), for: .valueChanged)
        return stepper
    }()
    
    lazy var distanceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 50
        stepper.stepValue = 10
        stepper.minimumValue = 50
        stepper.maximumValue = 200
        stepper.addTarget(self, action: #selector(distanceStepperPressed), for: .valueChanged)
        return stepper
    }()
    
    
    
    
    //square constraints
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
    }
    
    
    
    
    
    //MARK: - Actions
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - CGFloat(distanceStepper.value)
        UIView.animate(withDuration: animationStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset + CGFloat(distanceStepper.value)
        UIView.animate(withDuration: animationStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareLeft(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset - CGFloat(distanceStepper.value)
        UIView.animate(withDuration: animationStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareRight(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset + CGFloat(distanceStepper.value)
        UIView.animate(withDuration: animationStepper.value) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    

    @objc func animationStepperPressed(_ stepper: UIStepper) {
        animationStepper.value += 1
        animationStepper.value -= 1
        print("Changed Value: \(animationStepper.value)")
    }
    
    @objc func distanceStepperPressed(_ stepper: UIStepper) {
        distanceStepper.value += 1
        distanceStepper.value -= 1
        print("Distance Value: \(animationStepper.value)")
    }


    
    
    
    //MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
        view.addSubview(buttonStackViewLR)
        view.addSubview(animationStepper)
        view.addSubview(distanceStepper)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
        buttonStackViewLR.addSubview(leftButton)
        buttonStackViewLR.addSubview(rightButton)
    }
    
    private func configureConstraints() {
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
        constrainLeftButton()
        constrainRightButton()
        constrainUpDownButtonStackView()
        constrainLeftRightButtonStackView()
        constrainAnimationStepper()
        constrainDistanceStepper()
    }
    
 
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        
        upButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func constrainLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftButton.trailingAnchor.constraint(equalTo: buttonStackViewLR.trailingAnchor).isActive = true
    }
    
    private func constrainRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    
  
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainUpDownButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 100),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func constrainLeftRightButtonStackView() {
        buttonStackViewLR.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackViewLR.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackViewLR.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            buttonStackViewLR.heightAnchor.constraint(equalToConstant: 50),
            buttonStackViewLR.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func constrainAnimationStepper() {
        animationStepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationStepper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            animationStepper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    private func constrainDistanceStepper() {
        distanceStepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            distanceStepper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            distanceStepper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
}
    
    
    
    
    
    
