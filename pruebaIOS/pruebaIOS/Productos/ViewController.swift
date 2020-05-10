//
//  ViewController.swift
//  pruebaIOS
//
//  Created by Camiilo on 07/05/2020.
//  Copyright © 2020 Camiilo. All rights reserved.
//

import UIKit
import Alamofire
import ZVProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var listaProductos = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        serviceCons()
    }
    
    func showLoading(){
        ZVProgressHUD.maskType = .black
        ZVProgressHUD.show()
    }
    
    func hiddenLoading(){
        ZVProgressHUD.dismiss()
    }
    
    public func serviceCons() {
        Alamofire.request("http://localhost:3000/api/v1/counters").responseJSON { (response) -> Void in
            self.hiddenLoading()
            if let res = response.result.value {
                self.listaProductos = res as! [[String: Any]]
                self.tableView.reloadData()
                print(self.listaProductos)
            }else {
                self.alert(mensaje: "Error, Sin conexion con el servidor")
            }
        }
    }

    func alert(mensaje: String) {
        let alert = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func contadorBtnMenos(btnMenos: UIButton) {
        let index = btnMenos.tag
        let producto = listaProductos[index]
        let idProd = producto["id"] as! String
        if producto["count"] as! Int == 0 {
            alert(mensaje: "No tienes Productos")
        }else {
            contadorVal(idProd: idProd, accion: "dec")
        }
    }
    
    @objc func deletedItem(btnDeleted: UIButton){
        let index = btnDeleted.tag
        let producto = listaProductos[index]
        let idProd = producto["id"] as! String
        deletedVal(idProd: idProd)
    }
    
    func deletedVal(idProd: String) {
        let params: [String: Any] = [ "id" : idProd ]
        let url = "http://localhost:3000/api/v1/counter"
        Alamofire.request(url, method: .delete, parameters: params).responseJSON { (response) in
            if let res = response.result.value {
                self.alert(mensaje: "¡Producto eliminado!")
            }else {
                self.alert(mensaje: "Error al eliminar el producto")
            }
        }
    }
    
    
    @objc func contadorMasBtn(btnMas: UIButton) {
        let index = btnMas.tag
        let producto = listaProductos[index]
        let idProd = producto["id"] as! String
        contadorVal(idProd: idProd, accion: "inc")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaProductos.count
    }
    
    func contadorVal(idProd: String, accion: String) {
        let parametros: [String: Any] = [ "id": idProd ]
        let url = "http://localhost:3000/api/v1/counter/\(accion)"
        Alamofire.request(url, method: .post, parameters: parametros).responseJSON { (response) in
            if let res = response.result.value {
                self.listaProductos = res as! [[String: Any]]
                self.tableView.reloadData()
                print(res)
            }else {
                self.alert(mensaje: "Erorr al actualizar el contador")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellProducto", for: indexPath) as! cellGenericaTableViewCell
        cell.producNameLabel.text = (listaProductos[indexPath.row]["title"] as! String)
        cell.valProdLabel.text = String((listaProductos[indexPath.row]["count"] as! Int))
        cell.menosBtn.tag = indexPath.row
        cell.menosBtn.addTarget(self, action: #selector(contadorBtnMenos), for: .touchUpInside)
        cell.masBtn.tag = indexPath.row
        cell.masBtn.addTarget(self, action: #selector(contadorMasBtn), for: .touchUpInside)
        cell.deletedItemBtn.addTarget(self, action: #selector(deletedItem), for: .touchUpInside)
        return cell
    }
    

}

