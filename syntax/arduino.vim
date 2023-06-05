


"" SLIGHT MODIFICATION OF A PLUGIN CALLED `vim-arduino-syntax'
"" WITH THIS HEADER

" Vim syntax file
" Language:    Arduino
" Maintainer:  Sudar <sudar@sudarmuthu.com>
" Original Author:  Johannes Hoff <johannes@johanneshoff.com>
" Last Change: 27 April 2015
" License:     VIM license (:help license, replace vim by arduino.vim)

" Syntax highlighting like in the Arduino IDE

" Thanks to original author Johannes Hoff and Rik, Erik Nomitch, Adam Obeng and Graeme Cross for helpful feedback!
" Thanks to Rafi Khan for Arduino 1.5.x support

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" if version < 600
"   syntax clear
" elseif exists("b:current_syntax")
"   finish
" endif



" AS I ADD MORE LIBRARIES... TAKE THE KEYWORDS FROM ~/Arduino/libraries/LIBNAME/keywords.txt



syn keyword arduinoConstant HIGH LOW INPUT INPUT_PULLUP INPUT_PULLDOWN OUTPUT DEC BIN HEX OCT PI
syn keyword arduinoConstant HALF_PI TWO_PI LSBFIRST MSBFIRST CHANGE FALLING RISING DEFAULT EXTERNAL INTERNAL
syn keyword arduinoConstant INTERNAL1V1 INTERNAL2V56
syn keyword arduinoType boolean break byte case char class const continue default do
syn keyword arduinoType double else false float for if int long new null
syn keyword arduinoType private protected public register return short signed static String switch
syn keyword arduinoType this throw try true unsigned void while word boolean byte
syn keyword arduinoType char float int long word
syn keyword arduinoFunc abs acos asin atan atan2 ceil constrain cos degrees exp
syn keyword arduinoFunc floor log map max min radians random randomSeed round sin
syn keyword arduinoFunc sq sqrt tan pow bitRead bitWrite bitSet bitClear bit highByte
syn keyword arduinoFunc lowByte analogReference analogRead analogWrite attachInterrupt detachInterrupt delay delayMicroseconds digitalWrite digitalRead
syn keyword arduinoFunc interrupts millis micros noInterrupts noTone pinMode pulseIn shiftIn shiftOut tone
syn keyword arduinoFunc yield
syn keyword arduinoIdentifier Serial Serial1 Serial2 Serial3
syn keyword arduinoFunc SerialUSB begin end peek read
syn keyword arduinoFunc print println available availableForWrite flush setTimeout find findUntil parseInt parseFloat
syn keyword arduinoFunc readBytes readBytesUntil readString readStringUntil trim toUpperCase toLowerCase charAt compareTo concat
syn keyword arduinoFunc endsWith startsWith equals equalsIgnoreCase getBytes indexOf lastIndexOf length replace setCharAt
syn keyword arduinoFunc substring toCharArray toInt Keyboard Mouse press release releaseAll accept click
syn keyword arduinoFunc move isPressed setup loop
syn keyword arduinoConstant EEPROM
syn keyword arduinoFunc SoftwareSerial begin end read write available isListening overflow flush listen
syn keyword arduinoFunc peek
syn keyword arduinoConstant SPI SPI_CLOCK_DIV4 SPI_CLOCK_DIV16 SPI_CLOCK_DIV64 SPI_CLOCK_DIV128 SPI_CLOCK_DIV2 SPI_CLOCK_DIV8 SPI_CLOCK_DIV32 SPI_CLOCK_DIV64 SPI_MODE0
syn keyword arduinoConstant SPI_MODE1 SPI_MODE2 SPI_MODE3
syn keyword arduinoFunc begin end transfer setBitOrder setDataMode setClockDivider

" Adafruit_NeoPixel
syn keyword arduinoConstant NEO_RGB
syn keyword arduinoConstant NEO_RGBW
syn keyword arduinoConstant NEO_COLMASK
syn keyword arduinoConstant NEO_SPDMASK
syn keyword arduinoConstant NEO_KHZ800
syn keyword arduinoConstant NEO_KHZ400
syn keyword arduinoFunc begin
syn keyword arduinoFunc show
syn keyword arduinoFunc setPin
syn keyword arduinoFunc setPixelColor
syn keyword arduinoFunc fill
syn keyword arduinoFunc setBrightness
syn keyword arduinoFunc clear
syn keyword arduinoFunc updateLength
syn keyword arduinoFunc updateType
syn keyword arduinoFunc canShow
syn keyword arduinoFunc getPixels
syn keyword arduinoFunc getBrightness
syn keyword arduinoFunc getPin
syn keyword arduinoFunc numPixels
syn keyword arduinoFunc getPixelColor
syn keyword arduinoFunc sine8
syn keyword arduinoFunc gamma8
syn keyword arduinoFunc Color
syn keyword arduinoFunc ColorHSV
syn keyword arduinoFunc gamma32
syn keyword arduinoFunc pgm_read_byte

" Wire
syn keyword arduinoFunc begin setClock beginTransmission endTransmission requestFrom send receive onReceive onRequest Wire Wire1

" SPI
syn keyword arduinoConstant SPI SPI_MODE0 SPI_MODE1 SPI_MODE2 SPI_MODE3 SPI_CONTINUE SPI_LAST
syn keyword arduinoFunc begin end transfer setDataMode setClockDivider

" LiquidCrystal
syn keyword arduinoFunc LiquidCrystal begin clear home print setCursor cursor noCursor blink noBlink
syn keyword arduinoFunc display noDisplay autoscroll noAutoscroll leftToRight rightToLeft scrollDisplayLeft scrollDisplayRight createChar setRowOffsets

" WiFi
syn keyword arduinoConstant SSID BSSID RSSI
syn keyword arduinoFunc WiFi WiFiUdp Client Server firmwareVersion status connect write available config
syn keyword arduinoFunc setDNS read flush stop connected begin disconnect macAddress localIP subnetMask
syn keyword arduinoFunSec gatewayIP encryptionType getResult getSocket WiFiClient WiFiServer WiFiUDP beginPacket endPacket parsePacket
syn keyword arduinoFunc remoteIP remotePort

" RTClib ?
" Arduino-IRremote ?
" IRremote or IRLib ?
" Low-Power ?
" CryptoSuite ?
" HID ?
" Arduino-RDIF ?
" Arduino_LCD_Menu ?
" LiquidMenu ?


hi def link arduinoType Type
hi def link arduinoConstant Constant
hi def link arduinoFunc Function
hi def link arduinoIdentifier Identifier

syn match darkDebug "^\s*deebug.*$"
