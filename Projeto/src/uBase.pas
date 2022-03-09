unit uBase;

interface

uses
   SqlExpr, SysUtils;

type
   TBaseBanco = class
   protected
      FConexao: TSQLConnection;
      function RetornaUltimoCodigo(const ACampo, ATabela: string): Integer;
   private
      FErroPresente: string;
      function GetErroPresente: string;
      procedure SetErroPresente(const Value: string);
   public
      constructor Create(const AConexao: TSQLConnection);
      function InserirDadosBD(): Boolean; virtual; abstract;
      function ExecutarSql(): Boolean; virtual; abstract;
   published
      property ErroPresente: string read GetErroPresente write SetErroPresente;
   end;

implementation

uses DB;

{ TBaseBanco }

constructor TBaseBanco.Create(const AConexao: TSQLConnection);
begin
   Self.FConexao := AConexao;
end;

function TBaseBanco.GetErroPresente: string;
begin
   Result := Self.FErroPresente;
end;

function TBaseBanco.RetornaUltimoCodigo(const ACampo, ATabela: string): Integer;
var
   lQryUltimoCodigo: TSQLQuery;
begin
   lQryUltimoCodigo := TSQLQuery.Create(nil);
   try
      lQryUltimoCodigo.SQLConnection := Self.FConexao;
      lQryUltimoCodigo.SQL.Add(Format('SELECT MAX(%s) AS ULTIMO FROM %s', [ACampo, ATabela]));
      lQryUltimoCodigo.Open;
      Result := lQryUltimoCodigo.FieldByName('ULTIMO').AsInteger;
   finally
      FreeAndNil(lQryUltimoCodigo);
   end;
end;

procedure TBaseBanco.SetErroPresente(const Value: string);
begin
   Self.FErroPresente := Value;
end;

end.

