unit frmCalcViagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, frmMapa, frmCadVeiculo,
  frmResumoViag, System.RegularExpressions, FMX.Layouts;

type
  TCalculo = class(TForm)
    comboB: TComboBox;
    txtOrigem: TEdit;
    txtDestino: TEdit;
    btnLocal: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    txtValorG: TEdit;
    txtValorE: TEdit;
    txtValorD: TEdit;
    btnCalcular: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl_distancia: TLabel;
    lbl_tempo: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btnLocalizacao: TButton;
    btnAdicionarVeic: TButton;
    Label6: TLabel;
    Label8: TLabel;
    Layout1: TLayout;
    procedure btnLocalClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnLocalizacaoClick(Sender: TObject);
    procedure btnAdicionarVeicClick(Sender: TObject);
    procedure comboBMouseEnter(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure comboBChange(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Calculo: TCalculo;
  testando: string;

implementation

uses DM
{$IFDEF ANDROID}
       , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
     ;



{$R *.fmx}

procedure TCalculo.btnAdicionarVeicClick(Sender: TObject);
begin
     Application.CreateForm(TCadVeiculo, CadVeiculo);
     CadVeiculo.Show;


end;

function ExtractNumberInString ( sChaine: String ): String ;
var
    i: Integer ;
begin
    Result := '' ;
    for i := 1 to length( sChaine ) do
    begin
        if sChaine[ i ] in ['0'..'9'] then
        Result := Result + sChaine[ i ]
        else
        if sChaine [i] = ',' then
        Result := Result + sChaine[i];

    end ;
end ;

procedure TCalculo.btnCalcularClick(Sender: TObject);
var
mediaCarroG : Currency;
mediaCarroE : Currency;
mediaCarroD : Currency;
distance : Currency;
teste:string;


begin
      UDM.FDQueryMedia.Close;
      UDM.FDQueryMedia.ParamByName('pDescricao').AsString := testando;
      UDM.FDQueryMedia.Open();
      teste := ExtractNumberInString(lbl_distancia.Text);
      distance := StrToCurr(teste);
      mediaCarroG := UDM.FDQueryMediamediaG.AsCurrency;
      mediaCarroE := UDM.FDQueryMediamediaE.AsCurrency;
      mediaCarroD := UDM.FDQueryMediamediaD.AsCurrency;

      Application.CreateForm(TfrmResumo, frmResumo);
      frmResumo.txtTempo.Text := lbl_tempo.Text;
      frmResumo.txtKM.Text := lbl_distancia.Text;

      if MediaCarroG <> 0 then
      frmResumo.lbl_ConsumoG.Text := ((distance / mediaCarroG)*StrToCurr(txtValorG.Text)).ToString;

      if mediaCarroE <> 0 then
      frmResumo.lbl_ConsumoE.Text := ((distance / mediaCarroE)*StrToCurr(txtValorE.Text)).ToString;

      if mediaCarroD <> 0 then
      frmResumo.lbl_ConsumoD.Text := ((distance / mediaCarroE)*StrToCurr(txtValorD.Text)).ToString;

      frmResumo.Show;



end;

procedure TCalculo.btnLocalClick(Sender: TObject);
var
retorno: TJSONObject;
prows: TJSONPair;
arrayr: TJSONArray;
orows: TJSONObject;
arraye: TJSONArray;
oelementos: TJSONObject;
oduracao, odistancia: TJSONObject;
distancia_str, duracao_str: string;
distancia_int, duracao_int: integer;


begin
 RESTRequest1.Resource :=
   'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyAwjnJzF57fQddVy_dL8yTC01Zw7ufVuY8';
 RESTRequest1.Params.AddUrlSegment('origem', txtOrigem.Text);
 RESTRequest1.Params.AddUrlSegment('destino', txtDestino.Text);
 RESTRequest1.Execute;

 retorno := RESTRequest1.Response.JSONValue as TJSONObject;
 if retorno.GetValue('status').Value <> 'OK' then
 begin
    showmessage('Ocorreu um erro ao calcular a viagem.');
    exit;
end;

prows :=retorno.Get('rows');
arrayr := prows.JsonValue as TJSONArray;
orows := arrayr.Items[0] as TJSONObject;
arraye := orows.GetValue('elements') as TJSONArray;
oelementos := arraye.Items[0] as TJSONObject;


odistancia := oelementos.GetValue('distance') as TJSONObject;
oduracao := oelementos.GetValue('duration') as TJSONObject;

distancia_str := odistancia.GetValue('text').Value;
distancia_int := odistancia.GetValue('value').Value.ToInteger;

duracao_str := oduracao.GetValue('text').Value;
duracao_int := oduracao.GetValue('value').Value.ToInteger;

lbl_distancia.Text :=  distancia_str;
lbl_tempo.Text :=  duracao_str;

end;

procedure TCalculo.btnLocalizacaoClick(Sender: TObject);
 {$IFDEF ANDROID}
 var
   APermissaoGPS: string;
 {$ENDIF}

begin
{$IFDEF ANDROID}
     APermissaoGPS := JStringToString
      (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  //    PermissionsService.RequestPermissions([APermissaoGPS],
     //    procedure (const APermissions: TArray<string>;
   //          const AGrantResults: TArray<TPermissionsStatus>)
   //      begin
             // (Lenght(AGrantResults) = 1) and
          //      (AGrantResults[0] = TPermissionsStatus.Granted) then
     //           LocationSensor1.Active := True

      //       else
      //          LocationSensor1.Active := False
  //       end) ;
{$ENDIF}

     Application.CreateForm(TGPS, GPS);
     GPS.Show;

end;

procedure TCalculo.Button1Click(Sender: TObject);
begin
ShowMessage('teste');
end;





procedure TCalculo.comboBChange(Sender: TObject);
begin

        testando := comboB.Items.Strings[comboB.ItemIndex];
end;

procedure TCalculo.comboBMouseEnter(Sender: TObject);
begin

  UDM.FDQueryCarro.Close;
  UDM.FDQueryCarro.Open();
    try
        comboB.Items.Clear;


        while NOT UDM.FDQueryCarro.Eof do
        begin
            comboB.Items.AddObject(UDM.FDQueryCarro.FieldByName('descricao').AsString,
                                    TObject(UDM.FDQueryCarro.FieldByName('id').AsInteger));

              UDM.FDQueryCarro.Next;
        end;


         finally
        end;
end;

end.
