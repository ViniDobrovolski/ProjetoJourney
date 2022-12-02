unit frmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.TabControl, FMX.Objects, FMX.Layouts,
  System.Actions, FMX.ActnList;

type
  TLogin = class(TForm)
    ActionList1: TActionList;
    Change1: TChangeTabAction;
    Z: TLayout;
    Next: TImage;
    TabControl1: TTabControl;
    TabItem3: TTabItem;
    Image4: TImage;
    Label3: TLabel;
    Label6: TLabel;
    EditSenha1: TEdit;
    BtnCadastrar: TButton;
    EditEmail: TEdit;
    Label2: TLabel;
    TabItem4: TTabItem;
    Label4: TLabel;
    Image5: TImage;
    Label7: TLabel;
    EditLogin: TEdit;
    Label8: TLabel;
    EditSenha: TEdit;
    btnLogin: TButton;
    Change2: TChangeTabAction;
    HomeImage: TImage;
    TabItem1: TTabItem;
    Image3: TImage;
    Label1: TLabel;
    Label5: TLabel;
    Change3: TChangeTabAction;
    procedure BtnCadastrarClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure HomeImageClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation

uses
  DM, frmCalcViagem;

{$R *.fmx}

procedure TLogin.BtnCadastrarClick(Sender: TObject);
begin
  UDM.FDQueryPessoa.Close;
  UDM.FDQueryPessoa.Open();
  if (EditEmail.Text = EmptyStr) or (EditSenha1.Text = EmptyStr) then
    Abort;

  UDM.FDQueryPessoa.Append;
  UDM.FDQueryPessoalogin.AsString := EditEmail.Text;
  UDM.FDQueryPessoasenha.AsString := EditSenha1.Text;



  UDM.FDQueryPessoa.Post;
  UDM.FDConnection1.CommitRetaining;

  Change1.Execute;
end;

procedure TLogin.btnLoginClick(Sender: TObject);
begin

  UDM.FDQueryPessoa.Close;
  UDM.FDQueryPessoa.ParamByName('pnome').AsString := EditLogin.Text;
  UDM.FDQueryPessoa.Open();

  if not(UDM.FDQueryPessoa.IsEmpty) and (UDM.FDQueryPessoasenha.AsString = EditSenha.Text) then
  begin
    if not Assigned(Calculo) then
      Application.CreateForm(TCalculo, Calculo);
    Calculo.Show;
    Login.release;
    Login:=nil;

  end
  else
  begin
    ShowMessage('Login ou senha n�o confere');
  end;
end;

procedure TLogin.HomeImageClick(Sender: TObject);
begin
Change1.Execute;
end;

procedure TLogin.NextClick(Sender: TObject);
begin

     if TabControl1.Index = 1 then
     Change3.Execute
     else
     Change2.Execute;



end;

end.


