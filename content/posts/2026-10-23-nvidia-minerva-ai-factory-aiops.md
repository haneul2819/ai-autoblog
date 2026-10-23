---
title: "NVIDIA, AI 데이터센터 장애 원인을 추적하는 운영 플랫폼 Minerva 공개"
description: "NVIDIA가 수십만 GPU 규모 AI 데이터센터의 장애를 조기에 잡아내는 AIOps 플랫폼 Minerva를 공개했습니다. IREN 등이 도입을 준비 중입니다."
date: 2026-10-23
tags: ["NVIDIA", "인프라", "에이전트"]
sources:
  - title: "NVIDIA Unveils Minerva to Bring End-to-End Observability for AI Factories"
    url: "https://blogs.nvidia.com/blog/minerva-platform-infrastructure/"
  - title: "NVIDIA Launches Minerva AIOps Platform for AI Factory Observability"
    url: "https://www.unite.ai/nvidia-launches-minerva-aiops-platform-for-ai-factory-observability/"
---

## 왜 지금 이 주제인가

NVIDIA가 10월 22일, AI 데이터센터("AI 팩토리")의 운영 장애를 조기에 잡아내는 AIOps 플랫폼 Minerva를 공개했습니다. 최근 몇 주 동안 추론 스택과 학습 인프라를 둘러싼 오픈소스 공개가 이어졌지만(쿠버네티스 네이티브 추론 스택 llm-d, 가중치 동기화 가속기 NeMo-DCR 등), 이번 발표는 성격이 다릅니다. 모델을 더 빠르게 돌리는 문제가 아니라, 이미 돌아가는 수십만 GPU 규모 인프라에서 무엇이 고장 났는지를 찾아내는 운영 문제를 다룹니다. GPU 자원을 쓰는 거의 모든 AI 서비스 사업자에게 해당하는 주제라는 점에서 눈여겨볼 만합니다.

## 핵심 내용

NVIDIA 공식 블로그에 따르면 AI 팩토리는 "세계에서 가장 복잡한 운영" 중 하나로, 수십만 개의 GPU가 고속 네트워크로 묶여 동작합니다. 평소보다 살짝 뜨거운 GPU나 성능이 떨어진 NVMe 드라이브 하나가 전체 작업을 지연시킬 수 있지만, 기존 모니터링 도구는 네트워킹, 컴퓨팅, SRE, ML 팀이 각자 다른 조각만 보는 구조여서 이런 신호를 놓치기 쉽다고 설명합니다.

Minerva는 NVIDIA GPU, ConnectX SuperNIC, BlueField DPU, NVLink 스케일업 스위치, Spectrum-X 이더넷, NCCL, 스케줄러, AI 워크로드까지 인프라 전 구간의 텔레메트리를 한곳으로 모읍니다. 이 데이터를 시간당 수십억 개 단위로 지도학습·비지도학습 모델에 넣어 정상 동작 패턴을 학습하고, 새로운 이상 징후를 감지하며, 장애를 예측합니다. 핵심은 GPU·스위치·케이블과 그 위에서 돌아가는 작업을 논리적으로 엮은 동적 지식 그래프입니다. 이 그래프 덕분에 성능 저하가 어느 부품에서 시작됐는지를 역추적할 수 있다고 합니다. 관련된 사건들은 근본 원인과 함께 하나의 실행 항목으로 묶여, "알림 폭주"를 "초점이 맞춰진 인시던트"로 바꾼다는 설명입니다. 기술 매체 Unite.AI는 이 통합 효과의 사례로 NVMe 전력 장애의 복구 시간이 수일에서 6시간으로 줄고, 81개의 개별 알림이 1개의 통합 알림으로 묶여 클러스터 가동시간 54시간을 절감한 경우를 전했습니다.

Minerva에는 네이티브 AI 어시스턴트도 포함돼 있습니다. 운영자는 자연어로 클러스터 상태를 묻고 권장 대응 방안을 대화 형식으로 받을 수 있으며, 외부 에이전트형 AI 도구와도 연결할 수 있도록 설계됐습니다. 이는 기존에 네트워킹팀, 컴퓨팅팀, SRE팀, ML팀이 각자의 도구로 따로 들여다보던 장애 조사 과정을 하나의 대화창으로 모으려는 시도이기도 합니다. IREN의 최고기술책임자 Denis Skrinnikoff는 "운영팀이 네트워크, GPU, 실행 중인 작업 전체를 한눈에 볼 수 있어 선제적 유지보수에 더 집중할 수 있다"고 밝혔습니다. IREN 외에 Aolani, Bitdeer AI, IBM, Jio, Lambda, Quake AI, Tesla가 도입을 준비 중이며, Dell Technologies, Lenovo, Supermicro는 자사 AI 팩토리 운영 상품에 Minerva를 포함할 계획입니다.

## 의미와 한계

Minerva는 AI 인프라 경쟁의 축이 모델 성능과 추론 속도에서 가동률과 운영 비용으로 넓어지고 있음을 보여줍니다. 수십만 GPU 규모에서는 한 부품의 미세한 성능 저하가 전체 클러스터의 생산성을 갉아먹기 때문에, 장애를 몇 시간 안에 찾아내는 능력 자체가 비용 경쟁력이 됩니다. GPU 공급이 여전히 부족한 상황에서는 새 장비를 더 들이는 것보다 이미 깔린 장비의 가동률을 끌어올리는 쪽이 훨씬 저렴한 해법이라는 점도 이런 운영 플랫폼이 주목받는 배경입니다. 다만 공개된 수치는 아직 NVIDIA 자체 발표보다 외부 매체가 전한 사례 중심이고, 독립적인 벤치마크나 제3자 검증은 확인되지 않았습니다. 또 Minerva는 NVIDIA 하드웨어와 네트워크 스택을 전제로 설계된 플랫폼이라, 다른 제조사 장비가 섞인 혼합 인프라에서 얼마나 효과를 내는지는 아직 알려진 바가 없습니다. 초기 도입 기업들의 실제 운영 결과가 나와야 이 플랫폼의 실질적 가치를 가늠할 수 있을 것으로 보입니다.

## 한 줄 정리

NVIDIA가 수십만 GPU 규모 AI 데이터센터의 장애 원인을 자동으로 추적하는 운영 플랫폼 Minerva를 공개했습니다.
