Numpad1::

	SetTimer, PressTheKey, 200
	SetTimer, PressCtrl, 4700
	Return
	
	PressCtrl:
	Send, ^{Click}
	Return
	
	PressTheKey:
	Send, {w}
	Send, {e}
	Send, {r}
	Return

Numpad2::Pause Toggle