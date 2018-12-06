//
//  Tabla.swift
//  hello-maps
//
//  Created by Óscar Zamora on 12/5/18.
//  Copyright © 2018 Óscar Zamora. All rights reserved.
//

import UIKit

class Tabla: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var Tabla: UITableView!
    
    var establecimientos = [changarro]()

    override func viewDidLoad() {
        
        establecimientos.append(changarro(nombre: "Don Rata", latitud: 19.322727, longitud: -99.18289))
        establecimientos.append(changarro(nombre: "Puesto 2", latitud: 19.32722, longitud: -99.18288))
        establecimientos.append(changarro(nombre: "El primo II", latitud: 19.32713, longitud: -99.18278))
        
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return establecimientos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let establecimiento = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        establecimiento.textLabel?.text = "\(establecimientos[indexPath.row].nombre)"
        return establecimiento
    }
    
    @IBAction func unwindMapa(segue: UIStoryboardSegue){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alMapa"{
            let indexPath = Tabla.indexPathForSelectedRow
            let destination = segue.destination as! ViewController
            destination.nombreMapa = establecimientos[(indexPath?.row)!].nombre
            destination.latitudMapa = establecimientos[(indexPath?.row)!].latitud
            destination.longitudMapa = establecimientos[(indexPath?.row)!].longitud
        }
    }

}
