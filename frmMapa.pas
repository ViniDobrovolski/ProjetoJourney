unit frmMapa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Maps, FMX.Layouts,
  System.Sensors, System.Sensors.Components;

type
    TGPS = class(TForm)
    Layout1: TLayout;
    MapView1: TMapView;
    Origem: TLabel;
    LocationSensor1: TLocationSensor;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GPS: TGPS;

implementation

{$R *.fmx}

procedure TGPS.FormCreate(Sender: TObject) ;
begin
  MapView1.MapType := TMapType.Normal;
end;



procedure TGPS.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);

  var
     MyMarker: TMapMarkerDescriptor;
     posicao: TMapCoordinate;
begin
     MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude,
  NewLocation.Longitude);
	posicao.Latitude := NewLocation.Latitude;
	posicao.Latitude := NewLocation.Longitude;
	MyMarker := TMapMarkerDescriptor.Create(posicao, 'Estou aqui');
	MyMarker.Draggable := true;
	MyMarker.Visible := true;
	MyMarker.Snippet := 'EU';
	MapView1.addMarker (MyMarker);
	Label1.Text := NewLocation.Latitude.ToString().Replace(',','.');
	Label2.Text := NewLocation.Longitude.ToString().Replace(',','.');
end;

end.
