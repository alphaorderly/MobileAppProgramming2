//
//  DummyDataCreator.swift
//  GoRightNow
//
//  Created by 권동영 on 2022/05/08.
//

import Foundation

func demoGetCountryInfo() -> Country {
    let name = "아이슬란드"
    let immigInfo = "▸자국민, EEA/EFTA 회원국 국민(직계가족 포함) 및 아래 입국 가능 국가 출발 여행객 대상 입국 허용 - (입국 가능 국가)한국, 호주, 뉴질랜드, 일본, 르완다, 싱가포르, 태국 - 상기 외 유효한 사증 또는 거주허가 소지한 외국인 입국 가능 ※ 입국 허용 시 검역강화조치 ① 입국 전 온라인 등록 의무(능동감시 앱 설치 권고) ② 입국 시 코로나19 PCR 음성증명서(출발 72시간 이내 실시) 제시(영문 기재 필수) ③ 입국 시 적합한 격리 장소가 있음을 입증하지 못하는 경우 시설격리 의무(자가격리 중에 변이바이러스에 감염된 것으로 확인되는 경우 시설 격리로 전환) - 검사 및 시설 격리 비용 4.30.까지 무료(21.4.1.) ④ 입국 후 1차로 PCR 검사를 실시하고, 입국 후 5-6일 시점에 2차 PCR 검사를 실시하여 2차에 걸쳐 음성확인된 경우 격리 해제(21.1.15.) - 1차 검사와 2차 검사 사이의 기간(5-6일) 동안은 시설격리 - 검사 및 시설 격리 비용 4.30.까지 무료(21.4.1.) ※ 21.3.26.부터 입국자는 백신접종증명서 제출 시 상기 검역강화조치 중 △음성확인서 제출 및 △입국 후 실시하는 PCR 검사 및 격리 의무 면제 - 온라인 사전등록 의무는 유지\r\n- PCR 음성확인서는 경유지 공항이 요구하는 경우를 대비해 지참 권고"
    let immigInfoForKor = "▸22.2.25.부터 입국 시 코로나19 관련 증명서(백신접종 증명서, 회복증명서, 음성확인서) 제시 불요, 입국 후 격리 의무 없음"
    let demoData = Country(name: name, immigInfo: immigInfo, immigInfoForKor: immigInfoForKor)
    return demoData
}

func demoGetCountryInfoNoKor() -> Country {
    let name = "일본"
    let immigInfo = "▸21.1.14.부터 긴급사태 해제 선언 시까지 외국인의 신규입국 중지(21.1.13.) ※ 일본에 체류자격을 가진 자의 재입국은 가능 ▸21.1.14.부터 비즈니스 트랙 및 레지던스 트랙의 운용 중지(21.1.13.) ※ 모든 입국자는 비즈니스 트랙을 이용할 수 없으며, 입국 후 14일간 자택에서 대기(격리) 필요 ▸21.1.9.부터 모든 입국자 대상 검역강화 조치 실시 ※ 입국 시 공항에서 PCR 검사로 음성 확인 후 14일 자가격리(격리면제 제도 불비) ※ 입국 시 출국 전 72시간 내 실시한 코로나19 PCR 검사의 ‘검사증명’ 제출 필요(검사 증명 양식 및 관련 내용은 주한일본대사관 홈페이지 참고) ※ 입국자 중 검사증명 제출이 불가한 자는 입국 불가 및 항공기 탑승 제한 ※ 공항 내에서 영상통화/위치확인 가능한 어플리케이션 설치 및 서약서에 기재된 연락처의 진위 여부 확인 ▸(사증 제한) 21.1.13.부 외국인의 신규 입국 중지 조치에 따라 사증 발급 일시 중지 (한국, 홍콩, 마카오 등에 대한 사증면제조치 정지 계속) ▸(항공기 도착공항) 한국 등에서의 여객기편 도착공항을 나리타국제공항·간사이국제공항·주부(中部)국제공항 등 일부로 한정 ※ 제3국가발 일본 환승 관련, 입국심사를 통과하지 않고 환승 구역 내에서 환승 가능(기존과 동일) ▸21.6.1.부터 변이바이러스B.1.617 지정국 및 변이바이러스 유행국(한국 불포함) 출발 모든입국자는 △검역소장이 지정하는 장소(시설)에서 3~10일(출발국에 따라 차이) 대기, △입국 후 1~3회(출발국에 따라 차이) 코로나19 진단검사를 실시하여 음성 결과가 확인될 경우 시설 퇴소 및 입국 후 14일이 되는 시점까지 자가격리"
    let demoData = Country(name: name, immigInfo: immigInfo, immigInfoForKor: "none")
    return demoData
}
