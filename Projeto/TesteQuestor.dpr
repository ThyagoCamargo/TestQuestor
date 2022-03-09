program TesteQuestor;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uClientes in 'src\uClientes.pas',
  uBase in 'src\uBase.pas',
  uVeiculos in 'src\uVeiculos.pas',
  uVenda in 'src\uVenda.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
