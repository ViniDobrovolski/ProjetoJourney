unit DM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.IOUtils;

type
  TUDM = class(TForm)
    FDConnection1: TFDConnection;
    FDQueryPessoa: TFDQuery;
    FDQueryPessoalogin: TStringField;
    FDQueryPessoasenha: TStringField;
    FDQueryCarro: TFDQuery;
    FDQueryCarroplaca: TStringField;
    FDQueryCarrodescricao: TStringField;
    FDQueryCarromediaG: TLargeintField;
    FDQueryCarromediaE: TLargeintField;
    FDQueryCarromediaD: TLargeintField;
    FDQueryMedia: TFDQuery;
    FDQueryMediamediaG: TLargeintField;
    FDQueryMediamediaE: TLargeintField;
    FDQueryMediamediaD: TLargeintField;
    FDQueryPessoaid: TFDAutoIncField;
    FDQueryCarroid: TFDAutoIncField;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UDM: TUDM;

implementation

{$R *.fmx}

procedure TUDM.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin
  strSQL := 'create table IF NOT EXISTS Login (       ' + //
    'id integer not null primary key autoincrement,  ' + //
    'login varchar(60),                          ' + //
    'senha varchar(20))                           ';


  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;

    strSQL := 'create table IF NOT EXISTS Veiculo(' + //
    'id integer not null primary key autoincrement,  ' + //
    'placa varchar(20),  ' + //
    'descricao varchar(50),  ' + //
    'mediaG decimal,  ' +  //
    'mediaE decimal,' +     //
    'mediaD decimal) ';



  FDConnection1.ExecSQL(strSQL);

  FDQueryPessoa.Active := true;
  FDQueryCarro.Active := true;
  FDQueryMedia.Active := true;
end;

procedure TUDM.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: string;

begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
    'bd.db');
{$ENDIF}
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('D:\Users\VODOBROVOLSK.UNIVEL\Desktop\Projeto - 2° BIM\Banco',
    'bd.db');
{$ENDIF}
  FDConnection1.Params.Values['UseUnicode'] := 'False';
  FDConnection1.Params.Values['DATABASE'] := strPath;
end;

end.
