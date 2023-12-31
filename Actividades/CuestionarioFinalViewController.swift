//
//  CuestionarioFinalViewController.swift
//  Actividades
//
//  Created by Usuario on 04/10/23.
//

import UIKit

class CuestionarioFinalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textQuestion.numberOfLines = 0
        EndB.isHidden = true
        rectangle.layer.cornerRadius = 10
        
        Task {
            do{
                let questions = try await Question.fetchQuestions()
                updateUI(with: questions)
            }catch{
                displayError(QuestionError.itemNotFound, title: "No gusto acceder a las preguntas")
            }
        }
        // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var NadaDeAcuerdo: UIButton!
    
    @IBOutlet weak var PocoDeAcuerdo: UIButton!
    
    @IBOutlet weak var NiAcuerdoNi: UIButton!
    
    @IBOutlet weak var DeAcuerdo: UIButton!
    
    @IBOutlet weak var MuyDeAcuerdo: UIButton!
    
    @IBOutlet weak var textQuestion: UILabel!
    
    @IBOutlet weak var progressB: UIProgressView!
    

    @IBOutlet weak var EndB: UIButton!
    
    
    
    var engine = EcomplexityEngine()
    
    var userResponses = UserResponses()
    
    var userResponsesControllerF = UserResponsesControllerF()
    
    func updateUI(with questions:Questions){
        DispatchQueue.main.async {
            self.engine.initialize(q: questions)
            self.progressB.progress = self.engine.getProgress()
            self.textQuestion.text = self.engine.getTextQuestion()
            self.userResponses.usuarioID = UserDefaults.standard.integer(forKey: "usuarioID")
        }
    }
    
    func displayError(_ error: Error, title: String){
        DispatchQueue.main.async{
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func userAnswer(_ sender: UIButton){
        let answer = sender.titleLabel?.text
        let question = engine.getId()
        
        var ans = Answer(question: question, answer: "")
        
        switch answer!{
        case let str where str.contains("Totalmente de acuerdo"): ans.answer = "Totalmente de acuerdo"
        case let str where str.contains("En desacuerdo"): ans.answer = "En desacuerdo"
        case let str where str.contains("Ni en acuerdo ni en desacuerdo"): ans.answer = "Ni en acuerdo ni en desacuerdo"
        case let str where str.contains("De acuerdo"): ans.answer = "De acuerdo"
        default: ans.answer = "Totalmente de acuerdo"
        }
        userResponses.responses.append(ans)
        sender.backgroundColor = UIColor.green
        NiAcuerdoNi.isEnabled = false
        MuyDeAcuerdo.isEnabled = false
        PocoDeAcuerdo.isEnabled =  false
        NadaDeAcuerdo.isEnabled = false
        DeAcuerdo.isEnabled = false
        
        if progressB.progress == 1.0 {
            EndB.isHidden = false
            NiAcuerdoNi.isHidden = true
            MuyDeAcuerdo.isHidden = true
            PocoDeAcuerdo.isHidden =  true
            NadaDeAcuerdo.isHidden = true
            DeAcuerdo.isHidden = true
            
            
        }
        
        if engine.nextQuestion(){
            Task{
                do{
                    try await userResponsesControllerF.insertUserResponsesF(newUserResponses: userResponses)
                    updateUserResponses(title: "Las respuestas fueron almacenadas con exito en el servidor")
                }catch{
                    displayErrorUserResponses(UserResponsesErrorF.itemNotFound, title: "No se pudo alamacenar las respuestas en la base de datos")
                }
            }
        }else{
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: Selector("nextQuestion"), userInfo: nil, repeats: false)
            
        }
    }
    
    func updateUserResponses(title: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: "Datos almacenados con éxito", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continuar", style: .default)
            alert.addAction(continueAction)
            self.present(alert,animated: true)
        }
    }
    
    func displayErrorUserResponses(_ error: Error, title: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func nextQuestion(){
        textQuestion.text = engine.getTextQuestion()
        progressB.progress = engine.getProgress()
        DeAcuerdo.backgroundColor = UIColor.white
        NiAcuerdoNi.backgroundColor = UIColor.white
        MuyDeAcuerdo.backgroundColor = UIColor.white
        NadaDeAcuerdo.backgroundColor = UIColor.white
        PocoDeAcuerdo.backgroundColor = UIColor.white
        
        DeAcuerdo.isEnabled = true
        NiAcuerdoNi.isEnabled = true
        MuyDeAcuerdo.isEnabled = true
        NadaDeAcuerdo.isEnabled = true
        PocoDeAcuerdo.isEnabled = true
    }
    
    
    @IBOutlet weak var rectangle: UILabel!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
