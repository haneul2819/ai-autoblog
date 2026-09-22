---
title: "Amazon, 법원의 CFAA 판결 이후에도 Meta Muse 에이전트를 약관으로 차단"
description: "법원이 AI 쇼핑 에이전트의 접근을 CFAA 위반이 아니라고 판결한 넉 달 뒤, Amazon이 Meta의 Muse를 이용약관으로 차단했습니다."
date: 2026-09-22
tags: ["에이전트", "정책", "규제", "Meta", "산업동향"]
sources:
  - title: "Amazon blocks Meta's Muse AI assistant in new standoff over agentic shopping"
    url: "https://www.geekwire.com/2026/amazon-blocks-metas-muse-ai-assistant-in-new-standoff-over-agentic-shopping/"
  - title: "Meta's AI agent has been blocked from using Amazon.com"
    url: "https://techcrunch.com/2026/09/21/metas-ai-agent-has-been-blocked-from-using-amazon-com/"
  - title: "Ninth Circuit Rules on AI Agent 'Access' to Third-Party Websites Under CFAA"
    url: "https://www.cooley.com/news/insight/2026/2026-08-06-ninth-circuit-rules-on-ai-agent-access-to-third-party-websites-under-cfaa"
  - title: "FOR PUBLICATION UNITED STATES COURT OF APPEALS FOR THE NINTH CIRCUIT (26-1444)"
    url: "https://cdn.ca9.uscourts.gov/datastore/opinions/2026/08/04/26-1444.pdf"
---

## 왜 지금 이 주제인가

Amazon이 9월 21일 일요일 밤, Meta가 이달 초 내놓은 쇼핑 에이전트 Muse를 자사 쇼핑몰에서 차단하기 시작했습니다. Muse로 물건을 사려던 이용자에게는 "승인되지 않은 AI 에이전트의 접근은 Amazon 이용약관 위반"이라는 안내가 뜹니다. 이 조치가 눈에 띄는 이유는 시점입니다. 불과 넉 달 전인 8월 4일, 제9순회항소법원은 AI 쇼핑 에이전트가 웹사이트에 접근하는 행위가 컴퓨터사기남용법(CFAA) 위반이 아니라고 판결했습니다. 법원이 형사법의 문을 열어 준 지 얼마 지나지 않아, 플랫폼이 계약과 기술이라는 다른 수단으로 그 문을 다시 닫은 셈입니다. 에이전트가 사람을 대신해 웹을 돌아다니며 물건을 사는 일이 늘어날수록, 그 접근을 누가 통제할 권한을 갖는지를 둘러싼 다툼도 함께 커지고 있습니다.

## 핵심 내용

Amazon 대변인은 이번 조치에 대해 "고객을 대신해 다른 업체에서 구매를 대행하겠다는 제3자 애플리케이션은 공개적으로 운영되어야 하고, 서비스 제공자가 참여 여부를 결정할 권리를 존중해야 한다"고 밝혔습니다. 이어 "Muse 같은 에이전트형 제3자 애플리케이션도 동일한 의무를 지며, Meta에 Muse 경험에서 Amazon을 빼 달라고 요청했다"고 덧붙였습니다. 실제로 이용자가 Muse로 Amazon 상품을 사려 하면 "승인되지 않은 AI 에이전트의 계속된 접근은 Amazon 이용약관을 위반한다"는 팝업이 뜹니다. Meta는 Muse가 "이용자의 비밀번호나 결제 수단에 접근할 수 없고" 공유된 로그인 정보는 안전한 저장소에 보관된다고 설명했을 뿐, 차단 조치 자체에는 별도 입장을 내지 않았습니다.

이번 결정의 배경에는 Amazon과 Perplexity 사이의 소송전이 있습니다. Amazon은 Perplexity의 Comet 브라우저에 내장된 AI 에이전트가 이용자 몰래 자사 사이트에서 구매를 대행한다며 소송을 제기했고, 캘리포니아 연방지방법원은 2026년 3월 9일 Amazon 승소 취지의 예비 금지명령을 내렸습니다. 이용자가 자신의 Amazon 계정 접근을 허락했는지와 무관하게, Perplexity의 접근 자체가 Amazon의 승인을 받지 않았다는 논리였습니다.

그런데 제9순회항소법원은 8월 4일 이 금지명령을 뒤집었습니다. 항소심 판결문은 "Amazon 컴퓨터에 '접근'한 주체는 Perplexity의 AI 에이전트 도움을 받은 이용자 본인"이라고 판단했습니다. CFAA가 말하는 "접근"은 컴퓨터 시스템에 직접 들어가는 행위를 뜻하고, 법 조문의 "누구든지(whoever)"라는 표현도 소프트웨어 도구가 아니라 사람을 전제로 한다는 것입니다. Perplexity의 서버가 Amazon 서버와 직접 통신하지 않고 이용자의 컴퓨터를 경유했다는 사실이 판단의 핵심 근거였습니다. 결과적으로 법원은 Amazon이 CFAA와 캘리포니아 컴퓨터 데이터 접근·사기법(CDAFA) 위반을 근거로 승소할 가능성이 낮다고 봤습니다.

이 판결로 AI 에이전트 개발사는 적어도 CFAA라는 형사 성격의 강력한 법적 무기로부터는 어느 정도 보호를 받게 됐습니다. 하지만 판결문과 후속 법률 분석은 웹사이트 운영자에게 다른 수단이 남아 있다는 점도 함께 짚었습니다. 이용약관 강제, 계약 위반이나 불법행위 소송, 그리고 이번 Muse 사례처럼 처음부터 기술적으로 접근을 차단하는 방법입니다. Amazon은 법정 다툼 대신 약관과 봇 탐지 기술을 동원하는 쪽을 택했고, 이미 OpenAI와 Google의 쇼핑 관련 에이전트도 비슷한 방식으로 걸러 온 것으로 알려져 있습니다. Amazon은 이번 Muse 차단을 앞으로 에이전틱 쇼핑의 규칙을 가를 시험 사례로 보고 있다고 전해졌습니다.

## 의미와 한계

이번 사건은 AI 에이전트의 웹 접근을 둘러싼 다툼이 사법부의 판결만으로 끝나지 않는다는 것을 보여줍니다. 법원이 형사법 적용 범위를 좁혀도, 플랫폼은 약관 강제와 봇 탐지라는 자체 수단으로 사실상 같은 결과를 만들어 낼 수 있습니다. 소비자 입장에서는 에이전트가 아직 조사와 비교 용도로 주로 쓰이고 있어 당장의 불편은 크지 않겠지만, 에이전트를 통한 실제 구매가 늘어날수록 이런 플랫폼 간 차단이 광고 수익 배분이나 판매자 노출 방식까지 흔들 수 있습니다. 다만 이번 조치가 다른 소매업체나 다른 에이전트로 얼마나 확산될지, 그리고 계약이나 불법행위 소송 같은 다음 법적 다툼으로 이어질지는 아직 지켜봐야 할 부분이며, 이는 추측의 영역입니다.

## 한 줄 정리

법원이 AI 에이전트의 웹 접근을 CFAA 위반이 아니라고 판결하자, Amazon은 이용약관과 기술적 차단으로 대응 수단을 바꿨습니다.
