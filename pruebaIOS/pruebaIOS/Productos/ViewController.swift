//
//  ViewController.swift
//  pruebaIOS
//
//  Created by Camiilo on 07/05/2020.
//  Copyright © 2020 Camiilo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    let listaProductos = [
        [
            "nombre": "cafe",
            "cantidad" : 100
        ],
        [
            "nombre": "pan",
            "cantidad" : 50
        ],
        [
            "nombre": "leche",
            "cantidad" : 200
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func contadorBtnMenos(btnMenos: UIButton) {
        print("Boton Menos")
    }
    
    @objc func contadorMasBtn(btnMas: UIButton) {
        print("Boton Mas")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellProducto", for: indexPath) as! cellGenericaTableViewCell
        cell.producNameLabel.text = (listaProductos[indexPath.row]["nombre"] as! String)
        cell.valProdLabel.text = String((listaProductos[indexPath.row]["cantidad"] as! Int))
        cell.menosBtn.addTarget(self, action: #selector(contadorBtnMenos), for: .touchUpInside)
        cell.masBtn.addTarget(self, action: #selector(contadorMasBtn), for: .touchUpInside)
        return cell
    }
    

}

