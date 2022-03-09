unit uPrincipal;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, DBXpress, DB, SqlExpr, ExtCtrls, StrUtils, uClientes,
   uVenda, uVeiculos, uBase, ActnList;

type
   TForm1 = class(TForm)
      btnInsereClientes: TButton;
      SQLConnection1: TSQLConnection;
      gbxConexaoBanco: TGroupBox;
      edtUsuarioBanco: TLabeledEdit;
      edtSenhaBanco: TLabeledEdit;
      edtLibName: TLabeledEdit;
      edtVendorLib: TLabeledEdit;
      btnTestaConexao: TButton;
      btnInsereVeiculos: TButton;
      btnVender: TButton;
      ActionList1: TActionList;
      Action1: TAction;
      edtCaminhoBanco: TLabeledEdit;
      edtDriverFunc: TLabeledEdit;
      procedure Action1Execute(Sender: TObject);
      procedure Action1Update(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure btnVenderClick(Sender: TObject);
      procedure btnInsereVeiculosClick(Sender: TObject);
      procedure btnTestaConexaoClick(Sender: TObject);
      procedure btnInsereClientesClick(Sender: TObject);
   private
    { Private declarations }
      FListaDeClientes: TListaClientes;
      FListaDeVeiculos: TListaVeiculos;
      function CPFAleatorio(): string;
      function ConectaAoBanco: Boolean;
      procedure RemoveInstanciasListas;
      procedure NovoVeiculo(const AModelo: string; AAnoLancamento: Integer);
   public
    { Public declarations }
   end;

var
   Form1: TForm1;

implementation


{$R *.dfm}

procedure TForm1.btnInsereVeiculosClick(Sender: TObject);
var
   lVeiculo: TVeiculos;
   lIdxVeiculo: TObject;
begin
   SetLength(FListaDeVeiculos, 0);

   if (not ConectaAoBanco) then
   begin
      Exit;
   end;

   NovoVeiculo('MAREA', 2021);
   NovoVeiculo('UNO', 2020);
   NovoVeiculo('PULSE', 2022);
   NovoVeiculo('STRADA', 2018);
   NovoVeiculo('TIPO', 2019);

   ShowMessage('Veiculos inseridos com sucesso.');
end;

procedure TForm1.btnTestaConexaoClick(Sender: TObject);
begin
   if (ConectaAoBanco) then
   begin
      Showmessage('Conectado com sucesso!');
   end;
end;

procedure TForm1.btnVenderClick(Sender: TObject);
var
   lIdxClientes: Integer;
   lVenda: TVendaVeiculo;
begin
   if (not ConectaAoBanco) then
   begin
      Exit;
   end;
   if (Length(FListaDeClientes) <= 0) then
   begin
      ShowMessage('Nenhum cliente cadastrado.');
      Exit;
   end;
   if (Length(FListaDeVeiculos) <= 0) then
   begin
      ShowMessage('Nenhum cliente cadastrado.');
      Exit;
   end;

   try
      for lIdxClientes := low(FListaDeClientes) to High(FListaDeClientes) do
      begin
         lVenda := TVendaVeiculo.Create(SQLConnection1);
         try
            lVenda.CodigoCliente := FListaDeClientes[lIdxClientes].CodigoCliente;
            lVenda.CodigoVeiculo := FListaDeVeiculos[lIdxClientes].CodigoVeiculo;
            lVenda.DataVenda := Date;

            if (not lVenda.InserirDadosBD) then
            begin
               ShowMessage(Format('Erro ao realizar venda.' + sLineBreak + 'Erro: %s', [lVenda.ErroPresente]));
               Abort;
            end;
         finally
            FreeAndNil(lVenda);
         end;
      end;
      ShowMessage('Vendas realizadas com sucess!');
   finally
      RemoveInstanciasListas;
   end;
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  //
end;

procedure TForm1.Action1Update(Sender: TObject);
begin
   btnInsereClientes.Enabled := Length(FListaDeClientes) = 0;
   btnInsereVeiculos.Enabled := Length(FListaDeVeiculos) = 0;
   btnVender.Enabled := (not btnInsereClientes.Enabled) and (not btnInsereVeiculos.Enabled);
end;

procedure TForm1.btnInsereClientesClick(Sender: TObject);
var
   lCliente: TClientes;
   lIdxCliente: Integer;
begin
   SetLength(FListaDeClientes, 0);

   if (not ConectaAoBanco) then
   begin
      Exit;
   end;

   for lIdxCliente := 0 to pred(5) do
   begin
      lCliente := TClientes.Create(SQLConnection1);

      lCliente.CpfCnpj := CPFAleatorio();
      lCliente.Nome := Format('Cliente %s', [lCliente.CpfCnpj]);

      if (not lCliente.InserirDadosBD) then
      begin
         ShowMessage('Houve um erro ao inserir o cliente.' + sLineBreak + 'Erro: ' + lCliente.ErroPresente);
         Exit;
      end;

      SetLength(FListaDeClientes, Length(FListaDeClientes) + 1);
      FListaDeClientes[High(FListaDeClientes)] := lCliente;
   end;

   ShowMessage('Clientes inseridos com sucesso.');

end;

function TForm1.ConectaAoBanco: Boolean;
begin
   try
      SQLConnection1.Close;
      SQLConnection1.LoginPrompt := false;
      SQLConnection1.ConnectionName := 'TestQuestor';

      SQLConnection1.Params.Clear;
      SQLConnection1.DriverName := 'Interbase';

      SQLConnection1.Params.Add(Format('Password=%s', [Trim(edtSenhaBanco.Text)]));
      SQLConnection1.Params.Add(Format('User_Name=%s', [Trim(edtUsuarioBanco.Text)]));
      SQLConnection1.Params.Add(Format('Database=%s', [Trim(edtCaminhoBanco.Text)]));

      SQLConnection1.GetDriverFunc := Trim(edtDriverFunc.Text);
      SQLConnection1.LibraryName := Trim(edtLibName.Text);
      SQLConnection1.VendorLib := Trim(edtVendorLib.Text);

      SQLConnection1.Connected := True;
      Result := SQLConnection1.Connected;
   except
      on E: Exception do
      begin
         Result := False;
         Showmessage('Falha ao conectar com o banco de dados.' + sLineBreak + E.Message);
      end;
   end;
end;

function TForm1.CPFAleatorio: string;
var
   lIdxCpf: Integer;
begin
   Result := EmptyStr;
   for lIdxCpf := 1 to 11 do
   begin
      Result := Result + IntToStr(Random(9));
   end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   RemoveInstanciasListas;
end;

procedure TForm1.NovoVeiculo(const AModelo: string; AAnoLancamento: Integer);
var
   lVeiculo: TVeiculos;
begin
   lVeiculo := TVeiculos.Create(SQLConnection1);
   lVeiculo.Modelo := Trim(AModelo);

   lVeiculo.AnoLancamento := AAnoLancamento;

   if (not lVeiculo.InserirDadosBD) then
   begin
      Abort;
      ShowMessage(Format('Erro ao tentar inserir veiculo' + sLineBreak + 'Erro: %s', [lVeiculo.ErroPresente]));
   end;

   SetLength(FListaDeVeiculos, Length(FListaDeVeiculos) + 1);
   FListaDeVeiculos[High(FListaDeVeiculos)] := lVeiculo;

end;

procedure TForm1.RemoveInstanciasListas;
var
   lIdxLista: Integer;
begin
   for lIdxLista := Low(FListaDeClientes) to High(FListaDeClientes) do
   begin
      if (Assigned(FListaDeClientes[lIdxLista])) then
      begin
         FreeAndNil(FListaDeClientes[lIdxLista]);
      end;
   end;
   SetLength(FListaDeClientes, 0);

   for lIdxLista := Low(FListaDeVeiculos) to High(FListaDeVeiculos) do
   begin
      if (Assigned(FListaDeVeiculos[lIdxLista])) then
      begin
         FreeAndNil(FListaDeVeiculos[lIdxLista]);
      end;
   end;
   SetLength(FListaDeVeiculos, 0);

end;

end.

