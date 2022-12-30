```mermaid
%%{init:{"theme":"neutral"}}%%
graph LR
  subgraph  CB[Catalyst Builder]
    SP[< I > ServiceProvider]
  end

  subgraph Y[YourApp]
    MA[Flutter Router]
    DSP[< G > DefaultServiceProvider]
    AR[App Routes]
    S1[Screen/Widget 1]
    S2[Screen/Widget 2]
    DSP-->S1
    DSP-->S2
    DSP-->AR
    AR.-S1
    AR.-S2
  end

  subgraph E[Explorator]
    RR[RouteResolver]
    RB[< I > RouteBuilder]
    RP[< I > RouteProvider]
    MRB[MaterialRouteBuilder]
    MRB.->RB
    RR-->RB
    RR-->RP
  end

  MA-->RR
  RR-->SP
  DSP.->SP
  AR.->RP
  DSP-->RR
  DSP-->MRB
  AR-->SP

```