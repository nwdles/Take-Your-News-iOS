import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.keyboardDismissMode = .onDrag
    }

    @IBAction func didTapLoginButton() {
        guard
            let login = loginTextField.text,
            let password = passwordTextField.text
            else { return }
        
        jsonRequest(login: login, password: password)
    }
    
    func jsonRequest(login: String, password: String) {
        let login_obj = Login(login: login, password: password)
        
        UserDefaults.standard.set(login_obj.getBasicAuth(), forKey: "basicAuth")
        
        networkingService.request(endpoint: "/login", loginObject: login_obj) { [weak self] (result) in
            switch result {
            case .success(let user): self?.performSegue(withIdentifier: "loginSegue", sender: user)
            UserDefaults.standard.set(user.login, forKey: "login")
            UserDefaults.standard.set(user.name, forKey: "name")
            case .failure(let error):
                let alert = UIAlertController(title: "All favorite posts deleted!", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        //UserDefaults.standard.removeObject(forKey: "basicAuth")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainAppVC = segue.destination as? MainAppViewController,
            let categories = sender as? CategoryList {
            mainAppVC.categories = categories
            mainAppVC.modalPresentationStyle = .fullScreen
        }
    
    }

}

