//
//  ModifyListViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/15.
//

import UIKit

class ModifyListViewController: UIViewController {

    /// 手势储存point,保证有两个,为初始点和结束点
    private var touchPoints: [CGPoint] = []
    /// 手势选中cell.index
    private var sourceIndexPath: IndexPath?
    /// 将手势选中cell以image形式表现
    private var cellImageView = UIImageView()
    /// 被手势选中的cell
    private var currentCell:ModifyListTableViewCell!

    lazy var tableView : UITableView = {
        let view = UITableView.init(frame: self.view.frame, style: .plain)
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.rowHeight = 100
        view.register(UINib.init(nibName: "ModifyListTableViewCell", bundle: nil), forCellReuseIdentifier: ModifyListTableViewCell.ModifyCellID)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kNavAndTabHeight, right: 0)
        view.showsVerticalScrollIndicator = false
        return view
    }()

    var codeListArr: [[String:Any]] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = nil

        if FileTools.sharedInstance.isFileExisted(path: codePath) {
            /// 已经存在
            print("++++++++++++++++++++++++++++++")
            let dpathArr = NSArray(contentsOfFile: codePath)
            self.codeListArr = dpathArr as! [[String:Any]]
            print("plist 数组: \(dpathArr!)")
        } else {
            /// 没有数据
            print("没有数据!!!!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "修改列表"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "motify_list_success"), style: .plain, target: self, action: #selector(modifyListComplete))
        view.addSubview(tableView)

        if #available(iOS 11.0, *) {
            tableView.dragDelegate = self
            tableView.dropDelegate = self
            /// 程序内拖拽功能开启,默认ipad为true,iphone为false
            tableView.dragInteractionEnabled = true
            /// 系统自动调整scrollView.contentInset保证滚动视图不被tabbar,navigationbar遮挡
            tableView.contentInsetAdjustmentBehavior = .scrollableAxes
        } else {
            /// 系统自动调整scrollView.contentInset保证滚动视图不被tabbar,navigationbar遮挡
            self.automaticallyAdjustsScrollViewInsets = true
        }
    }

    /// 为cell注册拖拽方法
    private func dragCell(cell:UITableViewCell?) {
        if #available(iOS 11.0, *) {
            cell?.userInteractionEnabledWhileDragging = true
        } else {
            let pan = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture))
            cell?.addGestureRecognizer(pan)
        }
    }

    @objc func modifyListComplete(){
        self.navigationController?.popViewController(animated: true)
    }

}


extension ModifyListViewController {
    /***
     *  iOS11以下版本,实际上拖拽的不是cell,而是cell的快照imageView.并且同时将cell隐藏,当拖拽手势结束时,通过moveRow方法调换cell位置,进行数据修改.并且将imageView删除.再将cell展示出来,就实现了拖拽动画.
     */
    /// 手势方法
    @objc func longPressGesture(_ recognise: UILongPressGestureRecognizer) {
        let currentPoint: CGPoint = recognise.location(in: tableView)
        let currentIndexPath = tableView.indexPathForRow(at: currentPoint)
        guard let indexPath = currentIndexPath else {
            /// 将生成的cellimage清除
            initCellImageView()
            return
        }
        guard indexPath.row < self.codeListArr.count else {
            /// 将生成的cellimage清除
            initCellImageView()
            return
        }
        switch recognise.state {
        case .began:
            /// 手势开始状态
            longPressGestureBegan(recognise)
        case .changed:
            /// 手势拖拽状态
            longPressGestureChanged(recognise)
        default:
            /// 手势结束状态
            /// 清空保存的手势点
            self.touchPoints.removeAll()
            /// 将隐藏的cell展示
            if let cell = tableView.cellForRow(at: sourceIndexPath! ) {
                cell.isHidden = false
            }
            /// 将生成的cellimage清除
            initCellImageView()
        }
    }

    /// 长按开始状态调用方法
    private func longPressGestureBegan(_ recognise: UILongPressGestureRecognizer) {
        /// 获取长按手势触发时的接触点
        let currentPoint: CGPoint = recognise.location(in: tableView)
        /// 根据手势初始点获取需要拖拽的cell.indexPath
        guard let currentIndexPath = tableView.indexPathForRow(at: currentPoint) else { return }
        /// 将拖拽cell.index储存
        sourceIndexPath = currentIndexPath
        /// 获取拖拽cell
        currentCell = tableView.cellForRow(at: currentIndexPath ) as? ModifyListTableViewCell
        /// 获取拖拽cell快照
        cellImageView = getImageView(currentCell)
        /// 将快照加入到tableView.把拖拽cell覆盖
        cellImageView.frame = currentCell.frame
        cellImageView.extSetCornerRadius(8)
        tableView.addSubview(cellImageView)
        /// 将选中cell隐藏
        self.currentCell.isHidden = true
    }

    /// 拖拽手势过程中方法,核心方法,实现拖拽动画和数据的更新
    private func longPressGestureChanged(_ recognise: UILongPressGestureRecognizer) {
        let selectedPoint: CGPoint = recognise.location(in: tableView)
        let selectedIndexPath = tableView.indexPathForRow(at: selectedPoint)
        /// 将手势的点加入touchPoints并保证其内有两个点,即一个初始点,一个结束点,实现cell快照imageView从初始点到结束点的移动动画
        self.touchPoints.append(selectedPoint)
        if self.touchPoints.count > 2 {
            self.touchPoints.remove(at: 0)
        }
        var center = cellImageView.center
        center.y = selectedPoint.y
        // 快照x值随触摸点x值改变量移动,保证用户体验
        let pPoint = self.touchPoints.first
        let nPoint = self.touchPoints.last
        let moveX = nPoint!.x - pPoint!.x
        center.x += moveX
        cellImageView.center = center
        guard selectedIndexPath != nil else { return }
        /// 如果手势当前index不同于拖拽cell,则需要moveRow,实现tableView上非拖拽cell的动画,这里还要实现数据源的重置,保证拖拽手势后tableView能正确的展示
        if selectedIndexPath != sourceIndexPath {
            tableView.beginUpdates()
            /// 线程锁
            objc_sync_enter(self)
            /// 先更新tableView数据源
            var cellmode: [String:Any]
            cellmode = codeListArr[sourceIndexPath!.row]
            self.codeListArr.remove(at: sourceIndexPath!.row)
            if selectedIndexPath!.row < self.codeListArr.count {
                self.codeListArr.insert(cellmode, at: selectedIndexPath!.row)
            } else {
                self.codeListArr.append(cellmode)
            }
            objc_sync_exit(self)
            /// 调用moveRow方法,修改被隐藏的选中cell位置,保证选中cell和快照imageView在同一个row,实现动画效果
            self.tableView.moveRow(at: sourceIndexPath!, to: selectedIndexPath!)
            tableView.endUpdates()
            sourceIndexPath = selectedIndexPath
        }
    }
    /// 将生成的cell快照删除
    private func removeCellImageView() {
        self.cellImageView.removeFromSuperview()
        self.cellImageView = UIImageView()
        tableView.reloadData()
    }
    private func initCellImageView() {
        self.cellImageView.removeFromSuperview()
        tableView.reloadData()
    }
    /// 获取cell快照imageView
    private func getImageView(_ cell: UITableViewCell) -> UIImageView {
        UIGraphicsBeginImageContextWithOptions(cell.bounds.size, false, 0)
        cell.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView = UIImageView(image: image)
        return imageView
    }

}



extension ModifyListViewController: UITableViewDragDelegate,UITableViewDropDelegate {

    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = UIDragItem(itemProvider: NSItemProvider(object: UIImage()))
        return [item]
    }

    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }

    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
         return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
     }

     @available(iOS 11.0, *)
     func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
         // Only receive image data
         return session.canLoadObjects(ofClass: UIImage.self)
     }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dic :[String:Any] = self.codeListArr[sourceIndexPath.row]
        self.codeListArr.remove(at: sourceIndexPath.row)
        if destinationIndexPath.row > self.codeListArr.count {
            self.codeListArr.append(dic)
        } else {
            self.codeListArr.insert(dic, at: destinationIndexPath.row)
        }
    }
}




// MARK: 数据源和代理
extension ModifyListViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.codeListArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ModifyListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ModifyListTableViewCell.ModifyCellID, for: indexPath) as? ModifyListTableViewCell
        cell!.selectionStyle = .none
        cell!.txtLabel.text = self.codeListArr[indexPath.row]["name"] as? String

        /// 修改名称
        cell?.ModifyEditCodeNameBlock = { (cell:ModifyListTableViewCell) in
            let index = tableView.indexPath(for: cell)
            let dic = self.codeListArr[index!.row]
            let vc = ModifyCodeNameViewController()
            vc.dic = dic
            self.navigationController?.pushViewController(vc, animated: true)
        }

        /// 移动
        cell?.ModifyMoveListIndexBlock = {[weak self] (cell:ModifyListTableViewCell) in
            guard let mySelf = self else {return}
            mySelf.dragCell(cell: cell)
        }
        return cell!
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        view.backgroundColor = .white
        let txtLabel = UILabel.init(frame: CGRect(x: 24, y: 0, width: SCREEN_WIDTH, height: 60))
        txtLabel.text = "账号列表"
        txtLabel.textColor = .black
        txtLabel.font = UIFont().themeHNMediumFont(size: 20)
        view.addSubview(txtLabel)
        return view
    }
}
