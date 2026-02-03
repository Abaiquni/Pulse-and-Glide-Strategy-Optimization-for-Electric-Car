import gpxpy
import pandas as pd
from datetime import datetime

def gpx_to_csv(gpx_file_path, csv_file_path):
    with open(gpx_file_path, 'r') as gpx_file:
        gpx = gpxpy.parse(gpx_file)
    
    data = []
    for track in gpx.tracks:
        for segment in track.segments:
            for point in segment.points:
                data.append({
                    'latitude': point.latitude,
                    'longitude': point.longitude,
                    'elevation': point.elevation,
                    'time': point.time.isoformat() if point.time else None,
                    'speed': point.speed if hasattr(point, 'speed') else None,
                    'course': point.course if hasattr(point, 'course') else None,
                    'horizontal_dilution': point.horizontal_dilution if hasattr(point, 'horizontal_dilution') else None,
                    'vertical_dilution': point.vertical_dilution if hasattr(point, 'vertical_dilution') else None,
                    'position_dilution': point.position_dilution if hasattr(point, 'position_dilution') else None
                })
    
    df = pd.DataFrame(data)
    df.to_csv(csv_file_path, index=False)
    print(f"Converted {len(data)} points to {csv_file_path}")

# Usage
gpx_to_csv(r'F:\OneDrive - UGM 365\UGM Akademik\Semester 7\Skripsi\Workplace\ModelNew\Track\eprix\new\gpxdata.gpx', 'output.csv')