unit uVenda;

interface

uses
   UBase, SQLExpr, SysUtils, Controls;

type
   TVendaVeiculo = class(TBaseBanco)
   private
      FDataVenda: TDate;
      FCodigoVeiculo: Integer;
      FCodigoCliente: Integer;
      FCodigoVenda: Integer;
      function GetCodigovenda: Integer;
      procedure SetCodigoCliente(const Value: Integer);
      procedure SetCodigoVeiculo(const Value: Integer);
      procedure SetDataVenda(const Value: TDate);
   public
      function InserirDadosBD(): Boolean;
      function ExecutarSql(): Boolean;
      property CodigoVenda: Integer read GetCodigovenda;
      property CodigoCliente: Integer read FCodigoCliente write SetCodigoCliente;
      property CodigoVeiculo: Integer read FCodigoVeiculo write SetCodigoVeiculo;
      property DataVenda: TDate read FDataVenda write SetDataVenda;
   end;

implementation

{ TVendaVeiculo }

function TVendaVeiculo.ExecutarSql: Boolean;
begin

end;

function TVendaVeiculo.GetCodigovenda: Integer;
begin
   Result := Self.FCodigoVenda;
end;

function TVendaVeiculo.InserirDadosBD: Boolean;
var
   lQryInsert: TSQLQuery;
begin
   Result := False;
   lQryInsert := TSQLQuery.Create(nil);
   try
      lQryInsert.SQLConnection := Self.FConexao;
      lQryInsert.SQL.Add(' INSERT INTO VENDAS ');
      lQryInsert.SQL.Add(' (CODCLIENTE, CODVEICULO, DATAVENDA)');
      lQryInsert.SQL.Add(' VALUES ');
      lQryInsert.SQL.Add(' (:CODCLIENTE, :CODVEICULO, :DATAVENDA) ');

      lQryInsert.ParamByName('CODCLIENTE').AsInteger := Self.FCodigoCliente;
      lQryInsert.ParamByName('CODVEICULO').AsInteger := Self.FCodigoVeiculo;
      lQryInsert.ParamByName('DATAVENDA').AsDate := Self.FDataVenda;

      try
         lQryInsert.ExecSQL;
         Result := True;

         Self.FCodigoVenda := RetornaUltimoCodigo('CODIGO', 'VENDAS');
      except
         on E: Exception do
         begin
            Result := False;
            Self.ErroPresente := E.Message;
         end;
      end;
   finally
      FreeAndNil(lQryInsert);
   end;
end;

procedure TVendaVeiculo.SetCodigoCliente(const Value: Integer);
begin
   Self.FCodigoCliente := Value;
end;

procedure TVendaVeiculo.SetCodigoVeiculo(const Value: Integer);
begin
   Self.FCodigoVeiculo := Value;
end;

procedure TVendaVeiculo.SetDataVenda(const Value: TDate);
begin
   Self.FDataVenda := Value;
end;

end.

