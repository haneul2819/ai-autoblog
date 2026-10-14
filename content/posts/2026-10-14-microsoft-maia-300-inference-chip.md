---
title: "마이크로소프트, 차세대 AI 추론 전용 칩 Maia 300 공개"
description: "마이크로소프트가 커스텀 AI 추론 칩 Maia 300을 공개하고 2027년부터 대규모로 배포해 자사 서비스의 주력 추론 시스템으로 삼겠다고 밝혔습니다."
date: 2026-10-14
tags: ["Microsoft", "인프라", "추론비용", "반도체"]
sources:
  - title: "Microsoft announces Maia 300, its next-generation custom AI chip"
    url: "https://news.microsoft.com/source/emea/2026/10/microsoft-announces-maia-300-its-next-generation-custom-ai-chip/"
  - title: "Microsoft reveals Maia 300 AI chip as it works to reduce dependence on Nvidia, AMD"
    url: "https://finance.yahoo.com/technology/article/microsoft-reveals-maia-300-ai-chip-as-it-works-to-reduce-dependence-on-nvidia-amd-130000212.html"
  - title: "Microsoft Pushes Custom AI Chips with Azure Maia 300"
    url: "https://www.datacenterknowledge.com/data-center-chips/microsoft-pushes-custom-ai-chips-with-azure-maia-300"
  - title: "Microsoft Unveils first AI chip: Maia 100 Chip and Cobalt CPU"
    url: "https://www.analyticsvidhya.com/blog/2023/11/microsoft-unveils-first-ai-chip-maia-100-chip-and-cobalt-cpu/"
---

## 왜 지금 이 주제인가

마이크로소프트가 10월 12일, 자체 설계한 3세대 AI 칩 Maia 300을 공개했습니다. 2023년 11월 Ignite 콘퍼런스에서 처음 발표된 Maia 100이 내부 실험 성격이 강했던 것과 달리, 이번에는 자사 제품과 서비스를 떠받치는 주력 추론 시스템으로 전환하겠다는 목표를 명확히 내세웠습니다. 바로 전날인 10월 13일에는 AMD도 에이전트 전용 데이터센터 랙 설계 Helion을 발표했는데, 두 발표를 이어 보면 에이전트형 AI가 늘어나며 추론 물량이 급증하는 시점에 클라우드 사업자들이 엔비디아 GPU에 대한 의존을 얼마나 줄일 수 있는지를 보여주는 흐름이라는 점에서 함께 눈여겨볼 만합니다.

## 핵심 내용

마이크로소프트가 공개한 수치는 크게 세 가지입니다.

첫째, Maia 300은 "선도적인 GPU 기반 시스템"과 비교해 메가와트당 토큰 처리량이 40% 더 많다고 밝혔습니다. 전력이 데이터센터 운영비의 핵심 변수인 만큼, 같은 전력으로 더 많은 추론을 처리할 수 있다는 의미입니다.

둘째, 칩 96개로 구성한 랙 단위에서는 전작 Maia 200 대비 최대 7배 높은 토큰 처리량을 낸다고 설명했습니다. 개별 칩 성능보다 랙 전체의 처리량을 강조한 점이 눈에 띄는데, 이는 실제 데이터센터 운영에서 중요한 단위가 개별 칩이 아니라 랙이기 때문입니다.

셋째, 이미 상용화된 Maia 200은 전 세대보다 와트당 토큰 처리량이 1.7배 높아졌고, Microsoft 365 Copilot을 비롯한 자사 AI 기능에 실제로 적용되어 수억 명 규모의 사용자를 지원하고 있다고 밝혔습니다. 이는 Maia 300이 처음 투입되는 칩이 아니라, 이미 실전 검증을 거친 전작의 다음 단계라는 점을 보여줍니다.

마이크로소프트는 Maia 300이 긴 문맥을 다루는 추론, 지연 시간에 민감한 대화형 서비스, 여러 단계를 거치는 에이전트 작업을 염두에 두고 설계됐다고 밝혔습니다. 학습용 칩이 아니라 추론에 특화된 설계라는 점을 재차 강조한 것입니다. 배포 일정은 2027년부터로, 이때부터 기가와트 단위의 대규모 배포를 시작해 Maia 칩군을 마이크로소프트 제품과 서비스의 주력 AI 추론 시스템으로 삼을 계획입니다.

이번 발표에서 눈에 띄는 또 다른 지점은 Maia 칩의 활용 범위입니다. Maia 200은 이미 Microsoft Teams, Copilot, Cowork를 지원하고 있고 올해 안에 GitHub Copilot 지원도 추가될 예정인데, 이는 모두 마이크로소프트 자체 제품입니다. 2023년 11월 첫선을 보인 Maia 100이 TSMC 5나노 공정으로 만들어졌다는 점이 당시 공개됐던 것과 달리, 이번 Maia 300 발표에는 제조 공정이나 트랜지스터 수 같은 세부 사양은 포함되지 않았습니다.

## 의미와 한계

이번 발표는 클라우드 사업자들이 추론 비용을 낮추기 위해 범용 GPU에서 벗어나 자체 설계 칩으로 옮겨가는 흐름을 다시 확인시켜 줍니다. 구글의 TPU, 아마존의 Trainium·Inferentia에 이어 마이크로소프트도 Maia 칩군을 통해 엔비디아·AMD에 대한 하드웨어 의존도를 줄이려는 전략을 분명히 하고 있습니다. 추론 중심 워크로드가 늘어나는 상황에서 전력당 처리량을 높이는 것은 곧바로 운영비 절감으로 이어지기 때문에, 이 경쟁은 앞으로도 계속될 가능성이 큽니다.

다만 한계도 뚜렷합니다. 마이크로소프트가 공개한 수치는 모두 자체 측정치로, 비교 대상인 "선도적인 GPU 기반 시스템"이 구체적으로 무엇인지는 밝히지 않았습니다. 제3자가 독립적으로 검증한 벤치마크는 아직 없습니다. 또한 메모리 대역폭, 생산 파트너 같은 세부 기술 사양도 이번 발표에는 포함되지 않았습니다. 대규모 배포는 2027년부터로 아직 1년 넘게 남아 있어, 실제 데이터센터 환경에서 이 수치가 그대로 재현될지는 지켜봐야 합니다.

더 근본적인 차이는 외부 개방 여부입니다. 아마존은 Trainium·Inferentia를, 구글은 TPU를 각각 Azure의 경쟁 클라우드인 AWS와 Google Cloud에서 고객이 직접 빌려 쓸 수 있는 인스턴스로 제공하고 있습니다. 반면 마이크로소프트는 Maia 칩을 외부 고객용 Azure 인스턴스로 내놓지 않고, Copilot류의 자사 서비스에만 쓰겠다는 방침을 유지하고 있습니다. 이번 발표에서도 이 방침을 바꾸겠다는 언급은 없었습니다. 결국 Maia 300은 마이크로소프트가 자사 서비스의 추론 비용을 낮추는 수단이지, 아마존이나 구글처럼 칩 자체를 새로운 수익 모델로 파는 전략은 아직 아닙니다. 엔비디아 GPU 생태계를 뒷받침하는 CUDA 소프트웨어 스택에 맞먹는 개발 도구 지원이 Maia 칩군에 얼마나 갖춰져 있는지도 확인되지 않았는데, 이는 외부 개방 시점이 늦어지는 이유 중 하나로 보입니다.

## 한 줄 정리

마이크로소프트가 추론 전용 칩 Maia 300으로 자체 효율 수치를 내놓았지만, 독립 검증과 2027년 실제 배포 결과는 아직 남은 숙제입니다.
