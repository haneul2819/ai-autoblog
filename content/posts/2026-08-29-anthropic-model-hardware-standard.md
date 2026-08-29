---
title: "Anthropic, AI 에이전트가 실험 장비를 조작하는 규격 MHS를 프리뷰 공개"
description: "Anthropic이 AI 에이전트가 현미경과 로봇 팔 등 물리 장비를 조작하도록 하는 공통 규격 Model Hardware Standard의 리서치 프리뷰를 열었습니다."
date: 2026-08-29
tags: ["Anthropic", "Claude", "에이전트", "MCP", "자동화"]
sources:
  - title: "Previewing the Model Hardware Standard"
    url: "https://www.anthropic.com/news/model-hardware-standard-research-preview"
  - title: "Anthropic opens research preview for AI hardware standard"
    url: "https://www.investing.com/news/stock-market-news/anthropic-opens-research-preview-for-ai-hardware-standard-93CH-4879988"
  - title: "Anthropic previews a standard for AI agents running lab kit"
    url: "https://www.resultsense.com/news/2026-08-28-anthropic-model-hardware-standard/"
---

## 왜 지금 이 주제인가

Anthropic이 2026년 8월 27일 Model Hardware Standard(MHS)의 리서치 프리뷰 첫 단계를 시작했습니다. AI 에이전트가 현미경, 액체 취급 장비(liquid handler), 로봇 팔 같은 물리 장비를 직접 조작하도록 만드는 공통 규격입니다. 그동안 에이전트 표준화 논의는 대체로 소프트웨어 도구 호출 범위에 머물렀는데, MHS는 실험실과 생산 현장의 실제 기계를 대상으로 삼습니다. 발표 문서에 여러 연구 기관이 직접 돌린 결과가 함께 실려 있다는 점도 이 발표를 단순한 규격 제안과 구분해 줍니다.

## 규격이 정의하는 것

### 드라이버와 프리미티브

MHS는 운영체제와 장비 사이를 옮겨 주는 드라이버 소프트웨어를 표준화합니다. 명령은 read와 write라는 단순한 프리미티브로 정리됩니다. 온도를 읽는 동작은 get temperature, 온도를 설정하는 동작은 set temperature로 표현하는 식입니다. 장비마다 별도의 번역 프로그램을 붙이지 않아도 표준 형식으로 장비를 발견할 수 있습니다.

여기에 자연어 태그가 붙습니다. 장비의 특성과 안전 한계 같은 정보를 드라이버 안에 자연어로 직접 적어 두는 방식입니다. 모델은 이 설명을 읽고 장비가 감당하지 못하는 값을 피합니다.

접근 경로는 하나가 아닙니다. Model Context Protocol(MCP), 명령줄 인터페이스, 코드 파일 API 세 가지가 같은 드라이버 위에 올라가고, 명령 하나로 여러 장비를 함께 움직일 수 있습니다. MHS는 모델에 종속되지 않습니다. 프로그래머블 인터페이스가 있는 장비면 동작하고, 어떤 에이전트 하네스든 표준 프로토콜로 붙을 수 있습니다. Claude 전용 규격이 아니라는 뜻입니다.

### 프리뷰에서 나온 수치

Genentech은 BCA 단백질 정량 실험을 액체 취급 장비, 로봇 팔, 플레이트 리더에 걸쳐 자동화했습니다. Claude는 물에 대해 초당 약 140 마이크로리터, BSA 용액에 대해 초당 10 마이크로리터를 최적 유량으로 골랐습니다(각각 RMSE 0.016, 0.181).

QuEra Computing은 양자 컴퓨터의 레이저 주파수 락을 되찾는 작업에 적용했습니다. 700회 시도 중 695회를 성공해 99.3%를 기록했습니다. 기존 방식은 약 58% 확률로 성공했고 시도당 150초가량이 들었습니다.

Carnegie Mellon University는 연속 희석 용량-반응 실험 환경을 구성하는 데 약 8시간을 썼습니다. 벤더가 만들어 주는 셋업이 보통 수 주 걸리는 것과 비교되는 수치입니다. 실행 자체도 약 3배 빨랐습니다.

나머지 파트너들은 서로 다른 결을 보여 줍니다. University of Washington의 Baker 랩과 Pinglay 랩은 qPCR 장비 상태를 관찰하면서 로봇 팔로 장비 사이를 잇는 데 썼고, HHMI Janelia Research Campus는 벤더가 제각각인 일곱 개 이상의 프로그램에 흩어져 있던 이광자 현미경 제어를 하나로 묶었습니다. Tetsuwan Scientific은 오염 물질을 분석하는 qPCR 작업 흐름에 자사 ResearchOS 플랫폼을 통해 연결했습니다. 실험실 자동화라는 한 단어로 묶이지만 실제 과제는 장비 종류마다 다르고, 규격이 이 차이를 흡수할 수 있는지가 프리뷰의 관심사입니다.

오류 상황도 인위적으로 만들어 시험했습니다. 플레이트 누락, 플레이트 회전, 리더 사용 중, 카메라 연결 해제, 장비 접근 불가, 비상 정지 작동까지 여섯 가지입니다. 하드웨어 쪽에서는 Tecan, QIAGEN, Universal Robots, Doosan Robotics, Danaher, Automata, MBF Bioscience가 지원을 준비하고 있고, AWS의 Strands Robots와 Hugging Face의 LeRobot, Raspberry Pi도 이름을 올렸습니다.

## 의미와 한계

장비 통합 비용이 규격 하나로 줄어들면 실험 자동화의 병목이 하드웨어 배선에서 실험 설계 쪽으로 옮겨 갑니다. MCP가 모델과 소프트웨어 도구 사이에서 한 일을 물리 장비 쪽에서 반복하려는 시도로 읽힙니다. 특히 QuEra의 레이저 락 사례처럼 사람이 붙어 있어야 했던 반복 보정 작업은, 성공률과 소요 시간이 함께 개선되면 야간이나 주말에도 장비를 돌릴 수 있게 됩니다.

다만 Anthropic이 직접 밝힌 제약이 분명합니다. 모델은 범용 추론에는 강하지만 물리적, 화학적, 생물학적 제약을 다루는 데는 여전히 약하고 특히 오류를 진단할 때 그렇습니다. Genentech 사례에서도 액체를 더 부드럽게 다루는 값 쪽으로 사람이 유도해야 했습니다. 프로그래머블 인터페이스가 없는 장비는 아예 대상이 아닙니다.

규격 자체도 아직 공개되지 않았습니다. Anthropic은 파트너들과 안전 평가와 모범 사례를 만든 뒤 오픈소스로 풀겠다고 밝혔지만 시점은 제시하지 않았습니다. 그전까지는 신청으로 선별된 기관만 접근할 수 있습니다. 표준을 자처하는 규격이 한 회사의 관리 아래 머무는 기간이 길어지면 벤더들의 채택 유인이 갈릴 수 있다는 것이 이 대목에서 떠오르는 추측입니다.

## 한 줄 정리

에이전트가 소프트웨어를 넘어 실험 장비를 다루기 시작했고, 그 접점을 규격으로 굳히려는 첫 시도가 공개 검증 데이터와 함께 나왔습니다.
