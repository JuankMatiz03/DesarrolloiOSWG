//
//  addProductViewController.swift
//  pruebaIOS
//
//  Created by Camiilo on 08/05/2020.
//  Copyright © 2020 Camiilo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class addProductViewController: UIViewController {
   
    @IBOutlet weak var textFielProduct: UITextField!
    @IBOutlet weak var btnProd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
    @IBAction func btnProdAction(_ sender: UIButton) {
        if textFielProduct.text == "" {
            alert(mensaje: "¡Debes ingresar el nombre de el producto!")
        }else {
            addProduct(nombreProd: textFielProduct.text ?? "")
        }
        
    }
    
    func addProduct(nombreProd: String) {
        let parametros: [String: Any] = ["title": nombreProd]
        Alamofire.request("http://localhost:3000/api/v1/counter", method: .post, parameters: parametros).responseJSON { (response) in
            if let res = response.result.value {
                self.alert(mensaje: "Producto creado correctamente")
                self.navigationController?.popViewController(animated: true)
            }else {
                self.alert(mensaje: "Error al crear el producto")
            }
        }
    }
    
    func alert(mensaje: String) {
        let alert = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
