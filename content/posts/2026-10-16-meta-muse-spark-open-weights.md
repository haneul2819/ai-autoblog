---
title: "메타, 8160억 파라미터 코딩·에이전트 모델 Muse Spark Open 가중치 공개"
description: "메타가 코딩과 에이전트 작업에 특화된 816B 파라미터 모델의 가중치를 공개하며 미국 오픈웨이트 모델 중 가장 강력하다고 밝혔습니다."
date: 2026-10-16
tags: ["Meta", "오픈웨이트", "MoE", "벤치마크", "에이전트"]
sources:
  - title: "Muse Spark Is Now an Open-Weights Model"
    url: "https://pytorch.org/blog/muse-spark-open/"
  - title: "Meta releases 816B-parameter Muse Spark Open for coding and agent work"
    url: "https://siliconangle.com/2026/10/15/meta-releases-816b-parameter-muse-spark-open-for-coding-and-agent-work/"
  - title: "Meta's 816B-Parameter Muse Spark Open Weights Are Now Public"
    url: "https://www.unite.ai/metas-816b-parameter-muse-spark-open-weights-are-now-public/"
---

## 왜 지금 이 주제인가

메타가 2026년 10월 15일, 코딩·에이전트 작업에 특화된 모델 Muse Spark의 가중치를 Muse Spark Open이라는 이름으로 공개했습니다. 지난 8월 비공개로 선보인 Muse Spark 1.2·1.3과 같은 베이스 모델을 공유하는 버전으로, 메타는 "지금까지 나온 미국 오픈웨이트 모델 중 가장 강력하다"고 소개했습니다. 이틀 전 공개한 플래그십 Muse Wonder와 달리 이번 모델은 가중치를 직접 내려받아 쓸 수 있습니다.

## 핵심 내용

Muse Spark Open은 816B 총 파라미터 중 42B만 활성화되는 혼합전문가(MoE) 구조이며, 컨텍스트 윈도우는 100만 토큰입니다. 텍스트·이미지·오디오·비디오를 네이티브로 처리하는 멀티모달 모델로, 코드 생성과 디버깅, 대규모 코드베이스 이해, 장시간 에이전트 작업을 겨냥해 학습됐습니다. 단발성 도구 호출이 아니라 계획·행동·관찰·자기교정을 반복하도록 훈련됐고, 하위 작업을 나눠 서브에이전트를 조율하는 기능도 있습니다.

벤치마크로는 에이전트 능력을 재는 JobBench 61.8점, 도구 사용 MCP-Atlas 89.2점, 코딩 Terminal-Bench 2.1 76.4점을 기록했습니다. 종합 지능 지표 Artificial Analysis Intelligence Index는 39점입니다. 안전성 면에서는 내부 사이버 벤치마크에서 탈옥 시도의 99.2%를 거부했고, PolyGuard·RedCode·CyberBench 2024 평가에서 94.8%, 생물·화학 위험 요청 거부율은 98~99% 이상이었습니다. 메타의 안전 기준 Superintelligence Scaling Framework 공개 요건을 통과했다고 밝혔습니다.

라이선스는 새로 만든 "Muse Model License"를 따르며, 쓰거나 통합하는 데 비용이 들지 않습니다. 다만 호스팅 서비스로 판매해 12개월 매출이 2천만 달러를 넘는 기업은 메타와 별도 계약을 맺어야 합니다. PyTorch의 신규 커널 언어 Helion을 적용해 NVIDIA·AMD GPU에서 기존 전용 커널보다 1.03~3.95배 빨라졌다고 밝혔습니다.

## 의미와 한계

메타는 이번 공개로 GLM, Kimi, Qwen 계열 등 중국발 오픈웨이트 모델과의 경쟁에서 미국산 선택지를 강화하려는 의도를 보였습니다. 다만 공개된 벤치마크는 메타 자체 측정치이며, 제3자의 독립 재현 평가는 아직 없습니다. 매출 규모에 따라 재배포에 제약이 걸리는 라이선스 구조여서 아파치나 MIT 같은 완전 개방형 라이선스와는 다릅니다. 이 모델은 메타의 가장 앞선 에이전트 모델 Muse Wonder의 축소판에 가까우며, 플래그십 자체는 여전히 비공개입니다.

## 한 줄 정리

메타가 816B 파라미터 코딩·에이전트 모델의 가중치를 공개하며 미국산 오픈웨이트 모델 중 가장 강력하다고 밝혔지만, 수치는 자체 측정치이고 라이선스도 완전 개방형은 아닙니다.
