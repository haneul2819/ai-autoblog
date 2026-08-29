---
title: "Hugging Face, 399달러 오픈소스 이족보행 로봇 Microduck 공개"
description: "Hugging Face 산하 Pollen Robotics가 키 25cm 이족보행 로봇 Microduck을 399달러에 내놨습니다. 제어와 시뮬레이션, 강화학습 스택을 Apache 2.0으로 함께 열었습니다."
date: 2026-08-29
tags: ["로보틱스", "오픈소스", "강화학습", "HuggingFace"]
sources:
  - title: "Meet Microduck - Pollen Robotics"
    url: "https://pollen-robotics.com/microduck/blog/introducing-microduck/"
  - title: "pollen-robotics/microduck_rl - GitHub"
    url: "https://github.com/pollen-robotics/microduck_rl"
  - title: "pollen-robotics/microduck - GitHub"
    url: "https://github.com/pollen-robotics/microduck"
  - title: "Hugging Face is selling a cute $399 open source duck robot, Microduck - TechCrunch"
    url: "https://techcrunch.com/2026/08/27/hugging-face-is-selling-a-cute-399-open-source-duck-robot-microduck/"
---

## 왜 지금 이 주제인가

Hugging Face가 2025년 4월 인수한 프랑스 로봇 스타트업 Pollen Robotics가 8월 27일 Microduck을 공개했습니다. 키 25cm의 오리 모양 이족보행 로봇이고, 도입 가격은 세금과 배송비를 뺀 399달러입니다. 눈길이 가는 쪽은 가격보다 함께 열린 소프트웨어입니다. 제어 스택과 시뮬레이션 환경, 강화학습 코드, 그리고 시뮬레이션에서 학습한 정책을 실제 기체로 옮기는 sim2real 절차가 Apache 2.0 라이선스로 저장소에 그대로 올라와 있습니다. 이족보행 제어를 직접 학습시켜 보려는 사람이 재현 가능한 파이프라인 전체를 손에 넣게 됐다는 뜻입니다.

## 하드웨어와 학습 스택

### 기체

Microduck의 무게는 800g 미만이고, 서보 15개로 움직입니다. 센서는 카메라 한 대와 소형 깊이 센서, IMU 두 개입니다. 부리는 관절로 움직여 물건을 집습니다. Pollen Robotics는 물건을 옮길 때 몸 전체가 낮아지고 부리가 닫힌 뒤 물건이 함께 따라온다고 설명합니다. 걷기, 앉기, 웅크리기, 흔한 자세로 넘어졌을 때 다시 일어서기, 롤러스케이트가 기본 동작으로 들어 있어 코드를 쓰지 않아도 상자를 열자마자 움직입니다.

연산은 Rockchip RK3566 보드 위에서 여러 개의 데몬으로 나뉘어 돌아갑니다. 데몬끼리는 유닉스 소켓 위 JSON-RPC로 통신하고, 카메라 영상은 mediad가 WebRTC로 내보냅니다. 조작은 robotctl 명령줄 도구와 게임패드로 하며, duckctl을 쓰면 네트워크나 ssh 없이 노트북에서 블루투스로 바로 붙을 수 있습니다. 첫 기동 때 기체마다 고유한 소리를 만들어 낸다는 점도 밝혀 두었습니다.

### 정책 학습과 sim2real

학습 코드는 microduck_rl이라는 별도 저장소에 있습니다. mjlab을 통해 MuJoCo Warp를 시뮬레이터로 쓰고, 알고리즘은 PPO입니다. 정책은 50Hz로 학습한 뒤 ONNX로 내보내 실제 로봇 위에서 실행합니다.

이 저장소의 핵심은 공개된 sim2real 절차입니다. Dynamixel XL330 서보의 거동을 BAM 액추에이터 물리 모델로 시뮬레이터 안에 재현하고, 배터리 전압과 전압 강하, 명령 지연, 마찰에 도메인 랜덤화를 겁니다. 관절마다 ±1도의 기어 유격을 백래시로 모사하고, 인코더 피드백도 이 백래시 계층을 거쳐 읽히도록 만들었습니다. 관측은 61차원 규격 하나로 통일해 두어, 서로 다른 정책을 실제 로봇 위에서 바꿔 끼울 수 있습니다. 시뮬레이터는 Hugging Face Spaces에서도 돌려 볼 수 있습니다.

Pollen Robotics는 Microduck을 앞서 내놓은 Reachy Mini와 나란히 놓고, 사람과 주고받는 상호작용에 무게를 둔 쪽이 Reachy Mini이고 스스로 움직이는 행동을 다루는 쪽이 Microduck이라고 구분합니다. 카메라와 깊이 센서를 붙여 놓고 이동과 물체 조작까지 한 기체에서 다루게 한 것도 같은 맥락으로 보입니다.

## 의미와 한계

이족보행 강화학습은 오랫동안 값비싼 기체와 공개되지 않은 튜닝 노하우에 묶여 있었습니다. 시뮬레이터에서 잘 걷던 정책이 실물에서 무너지는 이유는 대개 액추에이터 특성, 기어 유격, 통신 지연처럼 논문 본문에 잘 적히지 않는 곳에 있습니다. Microduck 저장소는 그 부분을 구체적인 수치와 코드로 적어 두었고, 기체 자체가 399달러입니다. 강의실이나 개인 작업대에서 sim2real을 한 번 끝까지 돌려 보는 비용이 눈에 띄게 내려갑니다.

한계도 분명합니다. 첫 배송 목표는 2026년 크리스마스 이전이고 대상 지역은 북미와 유럽, 영국입니다. 아직 실물이 사용자 손에 들어간 단계가 아니어서, 공개된 절차가 개체별 제조 편차를 얼마나 견디는지는 확인되지 않았습니다. 소프트웨어는 Apache 2.0이지만 3D 모델은 CC BY-SA-NC라 상업적 재배포에는 제약이 붙습니다. 25cm에 800g 미만인 기체에서 얻은 결과가 더 큰 로봇으로 이어질지도 별개의 문제입니다. 다리 길이와 질량이 달라지면 도메인 랜덤화 범위와 보상 설계를 다시 잡아야 하는데, 공개된 절차만으로 자동으로 풀리는 부분이 아닙니다. 추측을 덧붙이자면, 당분간 이 저장소의 값들은 그대로 가져다 쓰는 설정값이 아니라 자기 기체에 맞춰 다시 재는 방법의 예시로 읽힐 가능성이 큽니다.

## 한 줄 정리

399달러짜리 이족보행 로봇과 함께, 시뮬레이션에서 실물로 정책을 옮기는 절차 전체가 Apache 2.0으로 공개됐습니다.
