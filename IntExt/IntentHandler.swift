import Intents

class IntentHandler: INExtension, ChangeColorIntentHandling {
    
    func handle(intent: ChangeColorIntent, completion: @escaping (ChangeColorIntentResponse) -> Void) {
        guard let defaults = UserDefaults(suiteName: "group.com.intenting"), let color = intent.color else {
            completion(ChangeColorIntentResponse.init(code: .failure, userActivity: nil))
            return
        }
        defaults.set(intent.color, forKey: "color")
        completion(.changeIt(color: color))
    }
    
}
