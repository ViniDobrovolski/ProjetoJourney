unit frmResumoViag;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.Maps, System.Sensors,
  System.Sensors.Components;

type
  TfrmResumo = class(TForm)
    Layout1: TLayout;
    txtTempo: TEdit;
    txtKM: TEdit;
    btnVoltar: TButton;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblConG: TLabel;
    lblConE: TLabel;
    lblConD: TLabel;
    lbl_ConsumoG: TLabel;
    lbl_ConsumoE: TLabel;
    lbl_ConsumoD: TLabel;
    MapViewResumo: TMapView;
    LocationSensor1: TLocationSensor;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmResumo: TfrmResumo;

implementation

{$R *.fmx}

procedure TfrmResumo.btnVoltarClick(Sender: TObject);
begin
  frmResumo.release;
  frmResumo:=nil;
end;

procedure TfrmResumo.FormCreate(Sender: TObject);
begin
MapViewResumo.MapType := TMapType.Normal;
end;



procedure TfrmResumo.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
     MyMarker: TMapMarkerDescriptor;
     posicao: TMapCoordinate;
begin
     MapViewResumo.Location := TMapCoordinate.Create(NewLocation.Latitude,
  NewLocation.Longitude);
	posicao.Latitude := NewLocation.Latitude;
	posicao.Latitude := NewLocation.Longitude;
	MyMarker := TMapMarkerDescriptor.Create(posicao, 'Estou aqui');
	MyMarker.Draggable := true;
	MyMarker.Visible := true;
	MyMarker.Snippet := 'EU';
	MapViewResumo.addMarker (MyMarker);
	Label1.Text := NewLocation.Latitude.ToString().Replace(',','.');
	Label2.Text := NewLocation.Longitude.ToString().Replace(',','.');

end;

end.
