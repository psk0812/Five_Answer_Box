//
//  MainViewController.swift
//  Five_Answer_Box
//
//  Created by 박서경 on 2023/09/12.
//
import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var items = [String]()
    var input : String = ""

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var up_label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 컬렉션 뷰의 레이아웃을 설정합니다.
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()

        // 셀을 등록합니다. 커스텀 셀 클래스를 등록해야 합니다.
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        up_label.numberOfLines = 0
        up_label.text = "한번은 당해도\n두번은 당하지 않겠다"
        up_label.layer.borderWidth = 2.0
        up_label.layer.borderColor = UIColor.systemMint.cgColor
        up_label.layer.cornerRadius = up_label.frame.height / 10
        
       
    }

    // 섹션 내 항목 수를 반환합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        
      
        let alertController = UIAlertController(title: "", message: "과목이름을 입력하세요", preferredStyle: .alert)

        // 입력 필드 추가
        alertController.addTextField { (textField) in
            textField.placeholder = "내용 입력"
        }

        // 취소 액션 추가
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // 확인 액션 추가
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            if let text = alertController.textFields?.first?.text {
                // 사용자가 입력한 내용을 처리
                // 데이터 소스 업데이트
                self.items.append(text)
               // 새로운 데이터를 추가하거나 원하는 방식으로 업데이트합니다.

                // UICollectionView 리로드
                self.collectionView.reloadData()
                print("입력된 내용: \(text)")
            }
        }
        alertController.addAction(okAction)

        // 모달 창 표시
        present(alertController, animated: true, completion: nil)
    
    }

    // 셀을 구성하고 반환합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // 셀 배경색 설정 (노란색)
        cell.backgroundColor = UIColor.systemYellow

                
                // 그림자 추가
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 2.0
        
        // 셀에 내용을 표시하거나 스타일링하는 로직을 추가해야 합니다.
        // 예를 들어, 셀에 텍스트 레이블을 추가하고 항목 데이터를 표시할 수 있습니다.
        let label = UILabel(frame: cell.contentView.bounds)
        label.textAlignment = .center
        label.text = items[indexPath.item]
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20.0) // 폰트 크기 20으로 설정하고 볼드 처리
        cell.contentView.addSubview(label)
        
        // 길게 눌렀을 때 셀을 삭제하기 위한 제스처 등록
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        cell.addGestureRecognizer(longPressGestureRecognizer)
        return cell
    }
    
    // 셀의 크기를 설정합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.8 // collectionView의 80% 가로 크기
        let height: CGFloat = 60.0 // 고정된 세로 크기
        return CGSize(width: width, height: height)
    }
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // 길게 누른 셀의 인덱스 가져오기
            if let indexPath = collectionView.indexPathForItem(at: gestureRecognizer.location(in: collectionView)) {
                // 사용자에게 삭제 확인 대화 상자 표시
                let alertController = UIAlertController(title: "삭제 확인", message: "정말로 이 항목을 삭제하시겠습니까?", preferredStyle: .alert)
                
                // 취소 액션 추가
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                // 삭제 액션 추가
                let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (action) in
                    // 데이터 소스에서 해당 항목 삭제
                    self.items.remove(at: indexPath.item)
                    
                    // 셀 삭제
                    self.collectionView.deleteItems(at: [indexPath])
                }
                alertController.addAction(deleteAction)
                
                // 모달 창 표시
                present(alertController, animated: true, completion: nil)
            }
        }
        
        
        
        
        
    }

}
