// react, imports, imports order, leaflet, styled components

/*** React imports ***/
import { useState } from React;

/*** Internal components ***/
import { CustomComponent } from './CustomComponent';

/*** Module imports ***/
import styled from 'styled-components';

/*** Components from packages ***/
import L from "leaflet";
import { MapContainer, TileLayer, GeoJSON, Marker, Popup, Circle } from 'react-leaflet';

/*** Data imports ***/
import { nyCountiesGeoJSON } from '../geojson/ny-counties';

/*** Image imports ***/
import markerIcon from '../assets/imgs/marker-icon.png';

/*** CSS imports ***/
import 'leaflet/dist/leaflet.css';
import "@maptiler/leaflet-maptilersdk";

