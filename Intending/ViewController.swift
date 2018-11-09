import UIKit
import Intents
import IntentsUI

extension UserDefaults {
    @objc dynamic var color: String {
        return string(forKey: "color") ?? "red"
    }
}

class ViewController: UIViewController {
    
    enum Color {
        case red, green, blue
        
        var uiColor: UIColor {
            switch self {
            case .red:
                return UIColor.red
            case .green:
                return UIColor.green
            case .blue:
                return UIColor.blue
            }
        }
        
        var string: String {
            switch self {
            case .red:
                return "red"
            case .green:
                return "green"
            case .blue:
                return "blue"
            }
        }
        
        init(string: String) {
            switch string {
            case "red":
                self = .red
            case "green":
                self = .green
            case "blue":
                self = .blue
            default:
                fatalError()
            }
        }
    }
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSiriButton()
    }
    
    func addSiriButton() {
        let button = INUIAddVoiceShortcutButton(style: .blackOutline)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        view.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        
        button.addTarget(self, action: #selector(addToSiri(_:)), for: .touchUpInside)
    }
    
    @objc
    func addToSiri(_ sender: Any) {
        let intent = ChangeColorIntent()
        if let colorString = UserDefaults(suiteName: "group.com.intenting")?.string(forKey: "color") {
            intent.color = colorString
        }
        if let shortcut = INShortcut(intent: intent) {
            let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func handle(color: Color) {
        view.backgroundColor = color.uiColor
        UserDefaults(suiteName: "group.com.intenting")?.set(color.string, forKey: "color")
        interaction(color: color.string).donate(completion: nil)
    }
    
    private func interaction(color: String) -> INInteraction {
        let intent = ChangeColorIntent()
        intent.color = color
        return INInteraction(intent: intent, response: nil)
    }

    @IBAction func didTapRed(_ sender: Any) {
        handle(color: .red)
    }
    
    @IBAction func didTapGreen(_ sender: Any) {
        handle(color: .green)
    }
    @IBAction func didTapBlue(_ sender: Any) {
        handle(color: .blue)
    }
}

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
