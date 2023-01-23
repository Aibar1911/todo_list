//
//  ViewController.swift
//  AibarList
//
//  Created by swift on 23.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var itens = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Keep in mind"
        
        
        view.addSubview(table)
        table.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
            }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "Новая запись", message: "Введите Новую запись", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "отменить", style: .cancel, handler: nil ))
        alert.addAction(UIAlertAction(title: "завершить", style: .default, handler: {[weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentItems = UserDefaults.standard.stringArray(forKey: "Items") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.set(currentItems, forKey: "Items")
                        self?.itens.append(text)
                        self?.table.reloadData()
                    }
                    
                }
                
            }
            
        }))
        alert.addTextField {field in
            field.placeholder = "Введите запись..."
        }
        present(alert, animated: true)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itens[indexPath.row]
        return cell
    }
}












