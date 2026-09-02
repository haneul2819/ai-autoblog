---
title: "Anthropic, Claude 응답에 보이지 않는 워터마크를 넣기 시작"
description: "Anthropic이 Claude Fable 5.1과 Mythos 5.1부터 텍스트 출력에 SynthID-Text 워터마크를 적용했습니다. EU AI Act 제50조 대응이자 상용 모델의 첫 기본 적용 사례입니다."
date: 2026-09-02
tags: ["Anthropic", "Claude", "규제", "정책", "안전성"]
sources:
  - title: "Introducing Claude Fable 5.1 and Claude Mythos 5.1"
    url: "https://www.anthropic.com/claude-fable-and-mythos-5-1"
  - title: "How Claude's text watermarking works"
    url: "https://www.anthropic.com/news/claude-text-watermark"
  - title: "How Claude marks AI-generated content"
    url: "https://support.claude.com/en/articles/16266773-how-claude-marks-ai-generated-content"
  - title: "Anthropic releases Claude Fable 5.1 and Mythos 5.1, cutting cache read prices by 75%"
    url: "https://thenextweb.com/news/claude-fable-mythos-5-1-eu-ai-act-watermark-detection-api-private-preview"
---

## 왜 지금 이 주제인가

Anthropic이 9월 1일 Claude Fable 5.1과 Claude Mythos 5.1을 공개했습니다. 코딩과 과학 연구 벤치마크 점수가 올랐고 캐시 읽기 가격이 100만 토큰당 0.25달러로 75% 내려간 점이 먼저 눈에 띕니다. 다만 실무 관점에서 더 오래 남을 변화는 따로 있습니다. 이 두 모델부터 Claude가 생성한 텍스트에 사람 눈에 보이지 않는 워터마크가 기본으로 들어갑니다. EU AI Act 제50조의 투명성 의무가 2026년 8월 2일부터 적용되면서 생성물에 기계가 읽을 수 있는 표시를 넣고 탐지 가능하게 하라는 요구가 발효됐고, 그 조항이 상용 모델의 기본 동작으로 옮겨진 사례가 나온 것입니다.

## 워터마크가 들어가는 방식

Anthropic은 Google DeepMind가 2024년 Nature에 발표한 SynthID-Text 방식을 채택했다고 밝혔습니다. 원리는 단어를 고르는 단계에 개입하는 것입니다. 언어 모델은 다음 단어를 확률 분포에서 뽑을 때 난수를 씁니다. SynthID-Text는 그 난수 자리에 암호 키와 앞 문맥을 결합한 값을 넣습니다. 결과물은 여전히 무작위로 보이지만, 키를 가진 쪽에서는 이 단어 배열이 키를 사용한 선택과 일관되는지를 통계적으로 검사할 수 있습니다.

핵심은 개입하는 지점입니다. Anthropic은 어느 쪽을 골라도 자연스러운 자리, 즉 여러 표현이 똑같이 타당해 품질 차이가 없는 선택에서만 분포를 조정한다고 설명합니다. 문서에는 원래라면 고려하지 않았을 단어를 억지로 밀어 넣는 방식이 아니라는 점이 명시돼 있습니다.

적용 범위는 모델 단위로 끊었습니다. 2026년 8월 2일 이후 출시된 Claude 모델은 출시 시점부터 표시를 지원하며, 현재 해당하는 모델은 Fable 5.1과 Mythos 5.1입니다. 이전 모델에 표시를 추가하는 작업은 진행 중이라고 밝혔습니다. 제품 기준으로는 Claude Platform(API), Claude 앱, Claude Code, Claude Cowork, Claude Tag에서 나온 출력이 모두 대상입니다.

텍스트가 아닌 파일에는 다른 방법을 씁니다. SVG, PNG, JPG 같은 지원 형식에는 C2PA(Coalition for Content Provenance and Authenticity) 표준을 따르는 서명된 출처 메타데이터를 붙입니다. 이쪽은 파일이 변조됐는지까지 확인할 수 있습니다.

탐지는 별도 API로 분리했고 현재는 비공개 프리뷰입니다. 규제 기관, 법 집행 기관, 언론, 팩트체커, 독립 연구자, 교육 기관, EU 시민사회 단체처럼 자격을 갖춘 조직과, 같은 의무를 지는 기업이 신청 대상입니다. 워터마크 자체에는 사용자나 소속 조직, 대화 내용에 관한 정보가 담기지 않는다고 Anthropic은 밝혔습니다. 사용자가 응답을 복사해 다른 곳에 붙여 넣어도 표시는 텍스트에 남습니다.

## 의미와 한계

Anthropic이 직접 밝힌 한계가 적지 않습니다. 단어 선택의 여지가 있어야 표시가 들어가므로, 사실을 나열하는 문단처럼 쓸 수 있는 표현이 정해진 글에는 표시가 성기게 들어갑니다. 사용자가 쓴 글을 다듬는 교정 작업은 대부분의 단어가 그대로 남기 때문에 표시가 거의 생기지 않고, 출력이 정확히 정해져야 하는 코드에는 사실상 들어가지 않습니다. 길이도 변수여서 짧은 문단은 통계적 판단의 근거가 부족합니다. 가벼운 편집은 견디지만 모든 단어를 바꾸는 전면 재작성은 표시를 지웁니다.

판정의 성격도 분명히 해 둘 필요가 있습니다. 표시가 검출되면 그 글이 Claude를 거쳤다는 신호일 뿐, 전체를 Claude가 썼다는 뜻은 아닙니다. 사람이 쓴 글을 Claude가 손본 경우도 검출될 수 있습니다. 반대로 표시가 없다고 해서 AI가 쓰지 않았다는 근거가 되지도 못합니다. 오래된 모델 출력이거나 형식 변환 과정에서 신호가 사라졌을 수 있기 때문입니다.

그렇다면 학교나 편집국이 이 도구를 단독 증거로 쓰기는 어렵습니다. 탐지 API를 자격 심사를 거친 조직에만 먼저 여는 선택도 그 부담과 무관하지 않아 보이는데, 이 부분은 추측입니다. 그럼에도 방향은 분명합니다. 규제가 요구한 것은 기계가 읽을 수 있는 표시였고, 주요 상용 모델이 그것을 기본값으로 켜기 시작했습니다. 남은 쟁점은 기술이 아니라 탐지 권한을 누구에게 얼마나 줄 것인가입니다.

## 한 줄 정리

EU AI Act 제50조가 요구한 생성물 표시가 Claude의 기본 동작으로 들어왔지만, 탐지 결과는 아직 단독 증거가 되기 어렵습니다.
