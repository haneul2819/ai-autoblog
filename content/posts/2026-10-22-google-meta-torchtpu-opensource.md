---
title: "구글·메타, PyTorch를 TPU에서 네이티브로 돌리는 TorchTPU 오픈소스 공개"
description: "구글과 메타의 PyTorch 팀이 공동 개발한 TorchTPU가 PyTorch Conference 2026에서 공개돼 TPU를 GPU와 동등한 네이티브 학습·추론 대상으로 만들었습니다."
date: 2026-10-22
tags: ["Google", "오픈소스", "인프라", "추론비용"]
sources:
  - title: "TorchTPU is now open source: Run native PyTorch on TPUs"
    url: "https://cloud.google.com/blog/topics/ai-infrastructure/torchtpu-is-now-open-source-run-native-pytorch-on-tpus"
  - title: "google-pytorch/torch_tpu"
    url: "https://github.com/google-pytorch/torch_tpu"
  - title: "TorchTPU - A Hybrid Eager/Compiled Architecture for Native PyTorch Execution on TPU"
    url: "https://arxiv.org/abs/2610.24161"
---

## 왜 지금 이 주제인가

구글과 메타의 PyTorch 팀이 공동 개발한 TorchTPU가 10월 20일 PyTorch Conference 2026에서 공개됐습니다. 그동안 PyTorch로 TPU를 쓰려면 별도 컴파일 계층인 PyTorch/XLA를 거쳐야 했고, 디버깅과 코드 호환성에서 GPU 대비 불편함이 있었습니다. TorchTPU는 이 계층을 걷어내고 TPU를 CPU, GPU와 같은 선상의 네이티브 디바이스로 다루게 만든 시도입니다. GitHub에 Apache 2.0 라이선스로 공개돼 누구나 바로 가져다 쓸 수 있다는 점에서 인프라 쪽 변화로 눈여겨볼 만합니다.

## 핵심 내용

TorchTPU는 모델 디버깅에 쓰는 eager 모드와, 프로덕션 환경에서 성능을 끌어올리는 torch.compile 통합을 함께 제공합니다. 개발 단계에서는 즉시 실행 결과를 확인하며 디버깅하고, 배포 단계에서는 컴파일 최적화로 전환해 TPU 활용률을 높이고 메모리 오버헤드를 줄이는 방식입니다. 표준 PyTorch API를 그대로 지원하며 분산 처리를 위한 네이티브 primitives도 기본으로 갖추고 있어, 기존 PyTorch 코드를 옮길 때 디바이스 지정만 바꾸는 수준의 작업으로 포팅이 가능하다고 설명합니다.

성능 지표로는 Qwen 3 8B 모델 기준 Model FLOPs Utilization(MFU)이 최대 52%까지 나왔고, 최대 8,192개의 Ironwood TPU(TPU v7x)까지 선형적인 확장성과 안정성을 확인했다고 밝혔습니다. 이는 TPU 클러스터를 늘릴수록 처리 효율이 꺾이지 않고 유지된다는 의미입니다.

생태계 통합도 폭넓게 이뤄졌습니다. Hugging Face Transformers v5부터는 device_map="tpu" 한 줄만 바꾸면 TPU로 배포할 수 있고, Diffusers는 eager 모드와 torch.compile, 텐서 병렬화를 그대로 지원합니다. 추론 쪽에서는 vLLM이 연속 배치와 양자화, 다중 칩 병렬화를 TPU에서도 쓸 수 있게 했고, SGLang은 RadixAttention으로 KV 캐시를 재사용하는 방식을 그대로 가져왔습니다. Ray는 CPU·GPU·TPU를 섞어 쓰는 이질적 컴퓨팅 오케스트레이션을, LiteRT는 안드로이드·iOS·브라우저 같은 엣지 디바이스 추론을 맡습니다. 학습 쪽에서는 TorchTitan이 Llama 3 405B 규모의 대규모 분산 학습까지 검증을 마쳤고, VeRL은 강화학습과 사후 학습 단계를 지원합니다. 분산 추론 라우팅을 맡는 llm-d 1.0은 쿠버네티스 기반으로 동작하며, CNCF 샌드박스 프로젝트로 올라가 있어 구글 혼자만의 도구가 아니라 여러 업체가 함께 관리하는 표준화 트랙을 밟고 있습니다.

실제 적용 사례로 구글은 Zenteiq가 GKE Inference Gateway와 llm-d를 TPU v6e 1,000개 규모 클러스터에 결합해 하루 생성 토큰 용량을 14.7억에서 59.7억으로, 집계 추론 처리량을 4배로 늘렸다고 소개했습니다. Hugging Face Transformers 테스트 스위트를 대상으로 한 전용 CI/CD 파이프라인을 구축해 야간 테스트로 호환성을 지속적으로 검증하고 있으며, 이 파이프라인에는 메타와 Hugging Face 외에도 Inferact, RadixArk, Red Hat, IBM 같은 외부 업체가 파트너로 참여하고 있다고 밝혔습니다.

## 의미와 한계

TorchTPU는 TPU 생태계의 오래된 약점, 즉 PyTorch 사용자가 CUDA 대비 느끼는 진입장벽을 낮추려는 시도입니다. 구글과 메타가 함께 움직였다는 점은 PyTorch 쪽 호환성 검증과 유지보수가 메타 내부 인력을 통해서도 이뤄질 수 있다는 뜻이어서, 커뮤니티 신뢰도 측면에서 의미가 있습니다. Apache 2.0으로 공개돼 클라우드 종속 없이 구글 TPU로 워크로드를 옮기는 선택지가 넓어진다는 점도 실질적인 변화입니다. 메타가 왜 이 작업에 자원을 들였는지는 공식적으로 설명되지 않았지만, PyTorch 생태계가 특정 GPU 업체에 지나치게 묶이지 않도록 하려는 전략으로 추정됩니다.

다만 공개된 성능 수치는 구글이 선택한 Qwen 3 8B 한 모델 기준이어서, 다양한 아키텍처와 모델 규모에서 동일한 MFU가 나올지는 아직 확인되지 않았습니다. 기존 PyTorch/XLA 대비 구체적으로 무엇이 얼마나 개선됐는지에 대한 직접 비교 수치도 공개 자료에는 나오지 않았습니다. vLLM이나 SGLang 같은 추론 엔진 연동도 발표 시점 기준으로는 기능 지원 여부만 확인됐을 뿐, GPU 환경과 비교한 실제 처리량이나 지연시간 수치는 공개되지 않았습니다. 실제 체감은 커뮤니티가 다양한 모델과 워크로드로 직접 검증한 뒤에야 드러날 것으로 보입니다.

## 한 줄 정리

구글과 메타가 TPU를 PyTorch의 네이티브 디바이스로 만든 TorchTPU를 오픈소스로 공개했습니다.
