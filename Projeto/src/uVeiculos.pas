unit uVeiculos;

interface

uses
   UBase, SQLExpr, SysUtils, DateUtils, Controls;

type
   TVeiculos = class(TBaseBanco)
   private
      FCodigoVeiculo: Integer;
      FModelo: String;
      FAnoLancamento: Integer;
      function GetCodigoVeiculo: Integer;
      procedure SetModelo(const Value: String);
      procedure SetAnoLancamento(const Value: Integer);
   public
      property CodigoVeiculo: Integer read GetCodigoVeiculo;
      property Modelo: String read FModelo write SetModelo;
      property AnoLancamento: Integer read FAnoLancamento write SetAnoLancamento;
      function InserirDadosBD(): Boolean;
      function ExecutarSql(): Boolean;
   end;

   TListaVeiculos = array of TVeiculos;
implementation

{ TVeiculos }

function TVeiculos.ExecutarSql: Boolean;
begin

end;

function TVeiculos.GetCodigoVeiculo: Integer;
begin
   Result := Self.FCodigoVeiculo;
end;

function TVeiculos.InserirDadosBD: Boolean;
var
   lQryInsert: TSQLQuery;
begin
   Result := False;
   lQryInsert := TSQLQuery.Create(nil);
   try
      lQryInsert.SQLConnection := Self.FConexao;
      lQryInsert.SQL.Add(' INSERT INTO VEICULOS ');
      lQryInsert.SQL.Add(' (MODELO, ANOLANCAMENTO)');
      lQryInsert.SQL.Add(' VALUES ');
      lQryInsert.SQL.Add(' (:MODELO, :ANOLANCAMENTO) ');

      lQryInsert.ParamByName('MODELO').AsString := Self.FModelo;
      lQryInsert.ParamByName('ANOLANCAMENTO').AsInteger := Self.FAnoLancamento;

      try
         lQryInsert.ExecSQL;

         Self.FCodigoVeiculo := RetornaUltimoCodigo('CODIGO', 'VEICULOS');
         Result := True;
      except
         on E: Exception do
         begin
            Self.ErroPresente := E.Message;
            Result := False;
         end;
      end;
   finally
      FreeAndNil(lQryInsert);
   end;
end;

procedure TVeiculos.SetAnoLancamento(const Value: Integer);
begin
   Self.FAnoLancamento := Value;
end;

procedure TVeiculos.SetModelo(const Value: String);
begin
   Self.FModelo := Value;
end;


end.

