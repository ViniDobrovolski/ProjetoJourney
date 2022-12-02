unit frmCadVeiculo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.TabControl, DM, FMX.Layouts;

type
  TCadVeiculo = class(TForm)
    TabControl1: TTabControl;
    TabItem3: TTabItem;
    Label3: TLabel;
    Label6: TLabel;
    txtDescricao: TEdit;
    BtnCadastrar: TButton;
    txtPlaca: TEdit;
    Label2: TLabel;
    txtTanque: TEdit;
    txtGasolina: TEdit;
    txtEthanol: TEdit;
    txtDiesel: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Layout1: TLayout;
    procedure BtnCadastrarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CadVeiculo: TCadVeiculo;

implementation

{$R *.fmx}

procedure TCadVeiculo.BtnCadastrarClick(Sender: TObject);
begin
  UDM.FDQueryCarro.Close;
  UDM.FDQueryCarro.Open();
  if (txtPlaca.Text = EmptyStr) or (txtDescricao.Text = EmptyStr) then
    Abort;

  UDM.FDQueryCarro.Append;
  UDM.FDQueryCarroplaca.AsString := txtPlaca.Text;
  UDM.FDQueryCarrodescricao.AsString := txtDescricao.Text;
  UDM.FDQueryCarromediaG.AsString := txtGasolina.Text;
  UDM.FDQueryCarromediaE.AsString := txtEthanol.Text;
  UDM.FDQueryCarromediaD.AsString := txtDiesel.Text;

  UDM.FDQueryCarro.Post;
  UDM.FDConnection1.CommitRetaining;


  CadVeiculo.release;
  CadVeiculo:=nil;
end;

 end.
