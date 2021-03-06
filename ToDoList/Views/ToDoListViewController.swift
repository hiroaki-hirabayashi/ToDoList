//
//  ViewController.swift
//  ToDoList
//
//  Created by Hiroaki-Hirabayashi on 2022/01/29.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    var itemArray = [
        "Apple",
        "banana",
        "natu"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // AppDelegate -> applicationWillEnterForegroundの通知
    @objc func viewWillEnterForeground(notification: Notification) {
        print("フォアグラウンド")
    }
    
    // AppDelegate -> applicationDidEnterBackgroundの通知
    @objc func viewDidEnterBackground(notification: Notification) {
        print("バックグラウンド")
    }
    
    @IBAction private func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        // アラート作成
        let alert = UIAlertController(title: "新しいToDoを追加します",
                                      message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "追加", style: .default) { action in
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        // アラートにTextField追加
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "新しいToDoを追加"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

// MARK: - TableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
}

// MARK: - TableViewDelegate
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
