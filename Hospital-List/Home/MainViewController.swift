//
//  MainViewController.swift
//  Hospital-List
//
//  Created by Eddy on 2022/09/30.
//

import CoreLocation
import UIKit

import NMapsMap
import RxCocoa
import RxSwift
import SnapKit

final class MainViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?

    private let mainViewModel: MainViewModel
    private let mainInfoView = MainInfoView()
    private let disposeBag = DisposeBag()
    private let hospitalListButton = HospitalListButton()
    private var currentHospital: Item?
    private var currentMarker: NMFMarker?

    private let mapView = NMFMapView()
    private var markers = [NMFMarker]()
    private let infoWindow = NMFInfoWindow()

    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "StartFlag")

        return imageView
    }()

    private let indicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true

        return activityIndicator
    }()

    init(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        requestLocation()
        bind()
        setLayout()
    }

    private func setView() {
        mainInfoView.isHidden = true
        self.view.backgroundColor = .systemMint
    }

    private func setLayout() {
        self.view.addSubview(mapView)
        self.view.addSubview(mainInfoView)
        self.view.addSubview(indicatorView)
        self.view.addSubview(hospitalListButton)
        self.mapView.addSubview(flagImageView)

        mapView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        mainInfoView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(hospitalListButton.snp.top).inset(-20)
        }

        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        hospitalListButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.mapView.snp.bottom).inset(-10)
        }

        flagImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func checkRadius() -> Double {
        let projection = mapView.projection
        let point = projection.point(from: mapView.cameraPosition.target)
        let currentPointRadius = Double(point.y)
        let metersPerPixel = Double(projection.metersPerPixel())
        let currentRadius = currentPointRadius * metersPerPixel

        return currentRadius
    }

    private func removeAllMark() {
        for marker in markers {
            marker.mapView = nil
        }
        markers.removeAll()
    }

    private func setMarker(marker: NMFMarker) {
        marker.captionRequestedWidth = 60
        marker.captionTextSize = 15
        marker.captionAligns = [NMFAlignType.top]
        marker.iconTintColor = .green
        marker.subCaptionColor = .systemIndigo
        marker.subCaptionTextSize = 10
        marker.subCaptionRequestedWidth = 70
    }

    private func tapEventMarker(overlay: NMFOverlay) -> Bool {
        if let marker = overlay as? NMFMarker {
            currentMarker?.iconTintColor = .red
            currentMarker?.captionText = ""
            currentMarker?.subCaptionText = ""

            if marker.infoWindow == nil {
                guard let item = marker.userInfo["tag"] as? Item else { return false }
                setMarker(marker: marker)
                marker.captionText = item.name
                marker.subCaptionText = item.address
                currentHospital = item
                mainViewModel.markerDidTap(item: item)
                infoWindow.open(with: marker)
                currentMarker = marker
            } else {
                infoWindow.close()
            }
        }
        return true
    }

    private func bind() {
        mainViewModel.markerItemsRelay
            .withUnretained(self)
            .bind { wself, items in
                items.forEach { item in
                    let marker = NMFMarker()
                    marker.iconImage = NMF_MARKER_IMAGE_BLACK
                    marker.iconTintColor = .red
                    marker.position = NMGLatLng(lat: item.yPos.positionValue, lng: item.xPos.positionValue)
                    marker.touchHandler = wself.tapEventMarker
                    marker.userInfo = ["tag":item]
                    marker.mapView = wself.mapView
                    wself.markers.append(marker)
                }
            }
            .disposed(by: disposeBag)

        mainViewModel.isLoadingRelay
            .withUnretained(self)
            .bind { wself, isLoading in
                switch isLoading {
                case true:
                    wself.indicatorView.startAnimating()
                case false:
                    wself.indicatorView.stopAnimating()
                }
            }
            .disposed(by: disposeBag)

        mainViewModel.errorRelay
            .withUnretained(self)
            .bind { wself, _ in
                AlertBuilder(target: wself).addAction("확인", style: .default)
                    .show("데이터를 읽어오지 못했습니다", message: nil, style: .alert)
            }
            .disposed(by: disposeBag)

        mainViewModel.infoRelay
            .withUnretained(self)
            .bind { wself, item in
                wself.mainInfoView.setData(item: item)
                wself.mainInfoView.isHidden = false
            }
            .disposed(by: disposeBag)

        mainInfoView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { wself, _ in
                wself.mainInfoView.isHidden = true
            }
            .disposed(by: disposeBag)

        mainInfoView.saveButton.rx.tap
            .withUnretained(self)
            .bind { wself, _ in
                guard let currentHospital = wself.currentHospital else { return }
                wself.mainInfoView.isHidden = true
                AlertBuilder(target: wself).addAction("확인", style: .default)
                    .show("병원 정보 저장에 성공했습니다!", message: nil, style: .alert)
                wself.mainViewModel.saveButtonDidTap(item: currentHospital)
            }
            .disposed(by: disposeBag)

        hospitalListButton.rx.tap
            .withUnretained(self)
            .bind { wself, _ in
                let hospitalViewModel = HospitalViewModel(storage: PersistentManager.shared)
                wself.present(HospitalListViewController(hospitalViewModel: hospitalViewModel), animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    private func requestLocation() {
        mapView.positionMode = .normal
        locationManager.delegate = self
        mapView.addCameraDelegate(delegate: self)

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            AlertBuilder(target: self)
                .addAction("확인", style: .default)
                .show("오류", message: "위치 서비스 제공이 불가능합니다.", style: .alert)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentLocation = manager.location
            let locationOverlay = mapView.locationOverlay
            locationOverlay.hidden = false

            guard let currentLocation = locations.first else { return }
            locationOverlay.location = NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude)

            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        AlertBuilder(target: self)
            .addAction("확인", style: .default)
            .show("오류", message: "사용자의 위치 정보 불러오기를 실패했습니다.", style: .alert)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            locationManager.requestLocation()
        }
    }
}

extension MainViewController: NMFMapViewCameraDelegate {
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        mainInfoView.isHidden = true
        mainViewModel.requestHospitalList(xPos: mapView.cameraPosition.target.lng, yPos: mapView.cameraPosition.target.lat, ServiceKey: .id, type: .type, radius: checkRadius())
        removeAllMark()
    }
}
