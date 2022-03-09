unit uClientes;

interface

uses
   UBase, SQLExpr, SysUtils;

type
   TClientes = class(TBaseBanco)
   private
      FCpfCnpj: string;
      FCodigoCliente: Integer;
      FNome: string;
      function GetCodigoCliente: Integer;
      procedure SetCpfCnpj(const Value: string);
      procedure SetNome(const Value: string);
   public
      property CodigoCliente: Integer read GetCodigoCliente;
      property Nome: string read FNome write SetNome;
      property CpfCnpj: string read FCpfCnpj write SetCpfCnpj;
      function InserirDadosBD(): Boolean;
      function ExecutarSql(): Boolean;
   end;

   TListaClientes = array of TClientes;
implementation

{ TClientes }

function TClientes.ExecutarSql: Boolean;
begin

end;

function TClientes.GetCodigoCliente: Integer;
begin
   Result := Self.FCodigoCliente;
end;

function TClientes.InserirDadosBD: Boolean;
var
   lQryInsert: TSQLQuery;
begin
   Result := False;
   lQryInsert := TSQLQuery.Create(nil);
   try
      lQryInsert.SQLConnection := Self.FConexao;
      lQryInsert.SQL.Add(' INSERT INTO CLIENTES ');
      lQryInsert.SQL.Add(' (NOME, CPF_CNPJ)');
      lQryInsert.SQL.Add(' VALUES ');
      lQryInsert.SQL.Add(' (:NOME, :CPF_CNPJ) ');

      lQryInsert.ParamByName('NOME').AsString     := Self.FNome;
      lQryInsert.ParamByName('CPF_CNPJ').AsString := Self.FCpfCnpj;

      try
         lQryInsert.ExecSQL;

         Self.FCodigoCliente := RetornaUltimoCodigo('CODIGO', 'CLIENTES');
         Result := True;
      except on E: Exception do
         begin
            Result := False;
            Self.ErroPresente := E.Message;
         end;
      end;
   finally
      FreeAndNil(lQryInsert);
   end;
end;

procedure TClientes.SetCpfCnpj(const Value: string);
begin
   Self.FCpfCnpj := Value;
end;

procedure TClientes.SetNome(const Value: string);
begin
   Self.FNome := Value;
end;

end.

