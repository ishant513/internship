import UIKit
import SwiftSocket

class ViewController: UIViewController {
  
  @IBOutlet weak var textView: UITextView!
  
  let host = "localhost"
  let port = 9000
    var client: TCPClient?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    client = TCPClient(address: host, port: Int32(port))
  }

    var uinput: String = "text box didn't connect"
    
    //our label to display input
    @IBOutlet weak var labelName: UILabel!
    
    //this is the text field we created
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBAction func buttonClick(sender: UIButton) {
        //getting input from Text Field
        uinput = textFieldName.text!
        
        //Displaying input text into label
        labelName.text = uinput
        uinput.append("\n")
    }
    
    @IBAction func connectButtonAction(){
        guard let client = client else { return }
        switch client.connect(timeout: 10) {
        case .success:
        appendToTextField(string: "Connected to host \(client.address)")
        case .failure(let error):
            appendToTextField(string: String(describing: error))
        }
    }
    
    @IBAction func sendButtonAction() {
    guard let client = client else { return }
      if let response = sendRequest(string: uinput, using: client) {
        appendToTextField(string: "Response: \(response)")
      }
  }
  
  
    
  private func sendRequest(string: String, using client: TCPClient) -> String? {
    appendToTextField(string: "Sending data ... ")
    appendToTextField(string: uinput)
    switch client.send(string: uinput) {
    case .success:
      return readResponse(from: client)
    case .failure(let error):
      appendToTextField(string: String(describing: error))
      return nil
    }
  }
  
  private func readResponse(from client: TCPClient) -> String? {
    guard let response = client.read(1024*10) else { return nil }
    
    return String(bytes: response, encoding: .utf8)
  }
  
  private func appendToTextField(string: String) {
    print(string)
    textView.text = textView.text.appending("\n\(string)")
  }
}
