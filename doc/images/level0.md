```mermaid
%%{init:{"theme":"neutral"}}%%
graph LR
    CB[Catalyst Builder]
    Y[YourApp]-->|resolve|E[Explorator]
    E-->|resolved route|Y
    Y-->CB
    E-->CB
```