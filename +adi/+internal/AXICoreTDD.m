classdef AXICoreTDD < adi.common.Attribute
    properties
        %BurstCount AXICoreTDD: Burst Count
        BurstCount
        %CounterInt AXICoreTDD: Counter Int
        CounterInt
        %DMAGateingMode AXICoreTDD: DMA Gateing Mode
        % 0 - none, 1 - rx_only, 2 - tx_only, 3 - rx_tx
        DMAGateingMode = 0; 
        Enable
        %EnableMode AXICoreTDD: Enable Mode
        % 1 - rx_only, 2 - tx_only, 3 - rx_tx
        EnableMode = 3;
        %FrameLength AXICoreTDD: Frame Length
        FrameLength
        %Secondary AXICoreTDD: Secondary
        Secondary
        %SyncTerminalType AXICoreTDD: Sync Terminal Type
        SyncTerminalType
        
        %TxDPoff AXICoreTDD: Tx DP Off (ms)
        TxDPoff = [0 0];
        %TxDPon AXICoreTDD: Tx DP On (ms) 
        TxDPon = [0 0];
        %TxOff AXICoreTDD: Tx Off (ms) 
        TxOff = [0 0];
        %TxOn AXICoreTDD: Tx Off (ms)
        TxOn = [0 0];
        %TxVCOoff AXICoreTDD: Tx VCO Off (ms) 
        TxVCOoff = [0 0];
        %TxVCOon AXICoreTDD: Tx VCO On (ms)
        TxVCOon = [0 0];
        %RxDPoff AXICoreTDD: Rx DP Off (ms)
        RxDPoff = [0 0];
        %RxDPon AXICoreTDD: Rx DP On (ms) 
        RxDPon = [0 0];
        %RxOff AXICoreTDD: Rx Off (ms) 
        RxOff = [0 0];
        %RxOn AXICoreTDD: Rx On (ms) 
        RxOn = [0 0];
        %RxVCOoff AXICoreTDD: Rx VCO Off (ms) 
        RxVCOoff = [0 0];
        %RxVCOon AXICoreTDD: Rx VCO On (ms) 
        RxVCOon = [0 0];
    end
    
    properties(Hidden)
        AXICoreTDDDevPtrNames = {'axi-core-tdd'};
        AXICoreTDDDevPtr
    end
        
    % Get/Set Methods for Device Attributes
    methods
        function result = get.BurstCount(obj)
            result = 0;
            if ~isempty(obj.AXICoreTDDDevPtr)
                result = str2double(obj.getDeviceAttributeRAW('burst_count', 128, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.BurstCount(obj, value)
            if obj.ConnectedToDevice
                obj.setDeviceAttributeRAW('burst_count', num2str(value), obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.CounterInt(obj)
            result = 0;
            if ~isempty(obj.AXICoreTDDDevPtr)
                result = str2double(obj.getDeviceAttributeRAW('counter_int', 128, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.CounterInt(obj, value)
            if obj.ConnectedToDevice
                obj.setDeviceAttributeRAW('counter_int', num2str(value), obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.DMAGateingMode(obj)
            result = 0;
            if ~isempty(obj.AXICoreTDDDevPtr)
                ResultStr = obj.getDeviceAttributeRAW('dma_gateing_mode', 128, obj.AXICoreTDDDevPtr);
                switch ResultStr
                    case "none"
                        result = 0;
                    case "rx_only"
                        result = 1;
                    case "tx_only"
                        result = 2;
                    case "rx_tx"
                        result = 3;
                end
            end
        end
        
        function set.DMAGateingMode(obj, value)
            validateattributes( value, { 'double', 'single', 'uint32'}, ...
                { 'real', 'nonnegative','scalar', 'finite', 'nonnan', 'nonempty','integer','>=',0,'<=',3}, ...
                '', 'DMAGateingMode');
            if obj.ConnectedToDevice
                switch value
                    case 0
                        ValueStr = 'none';
                    case 1
                        ValueStr = 'rx_only';
                    case 2
                        ValueStr = 'rx_only';
                    case 3
                        ValueStr = 'rx_tx';
                end
                obj.setDeviceAttributeRAW('dma_gateing_mode', ValueStr, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.Enable(obj)
            result = 0;
            if ~isempty(obj.AXICoreTDDDevPtr)
                result = str2double(obj.getDeviceAttributeRAW('en', 128, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.Enable(obj, value)
            if obj.ConnectedToDevice
                obj.setDeviceAttributeRAW('en', num2str(value), obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.EnableMode(obj)
            result = 3;
            if ~isempty(obj.AXICoreTDDDevPtr)
                ResultStr = obj.getDeviceAttributeRAW('en_mode', 128, obj.AXICoreTDDDevPtr);
                switch ResultStr
                    case "rx_only"
                        result = 1;
                    case "tx_only"
                        result = 2;
                    case "rx_tx"
                        result = 3;
                end
            end
        end
        
        function set.EnableMode(obj, value)
            validateattributes( value, { 'double', 'single', 'uint32'}, ...
                { 'real', 'nonnegative','scalar', 'finite', 'nonnan', 'nonempty','integer','>=',1,'<=',3}, ...
                '', 'EnableMode');
            if obj.ConnectedToDevice
                switch value
                    case 1
                        ValueStr = 'rx_only';
                    case 2
                        ValueStr = 'rx_only';
                    case 3
                        ValueStr = 'rx_tx';
                end
                obj.setDeviceAttributeRAW('en_mode', ValueStr, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.FrameLength(obj)
            result = 0;
            if ~isempty(obj.AXICoreTDDDevPtr)
                result = str2double(obj.getDeviceAttributeRAW('frame_length_ms', 128, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.FrameLength(obj, value)
            if obj.ConnectedToDevice
                obj.setDeviceAttributeRAW('frame_length_ms', num2str(value), obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.Secondary(obj)
            result = 0;
            if ~isempty(obj.AXICoreTDDDevPtr)
                result = str2double(obj.getDeviceAttributeRAW('secondary', 128, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.Secondary(obj, value)
            if obj.ConnectedToDevice
                obj.setDeviceAttributeRAW('secondary', num2str(value), obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.SyncTerminalType(obj)
            result = 0;
            if ~isempty(obj.AXICoreTDDDevPtr)
                result = str2double(obj.getDeviceAttributeRAW('sync_terminal_type', 128, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.SyncTerminalType(obj, value)
            if obj.ConnectedToDevice
                obj.setDeviceAttributeRAW('sync_terminal_type', num2str(value), obj.AXICoreTDDDevPtr);
            end
        end
    end
    
    % Get/Set Methods for Channel Attributes
    methods
        function result = get.TxDPoff(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'dp_off_ms', true, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'dp_off_ms', true, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.TxDPoff(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'dp_off_ms', num2str(value(1)), true, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'dp_off_ms', num2str(value(2)), true, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.TxDPon(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'dp_on_ms', true, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'dp_on_ms', true, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.TxDPon(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'dp_on_ms', num2str(value(1)), true, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'dp_on_ms', num2str(value(2)), true, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.TxOff(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'off_ms', true, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'off_ms', true, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.TxOff(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'off_ms', num2str(value(1)), true, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'off_ms', num2str(value(2)), true, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.TxOn(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'on_ms', true, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'on_ms', true, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.TxOn(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'on_ms', num2str(value(1)), true, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'on_ms', num2str(value(2)), true, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.TxVCOoff(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'vco_off_ms', true, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'vco_off_ms', true, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.TxVCOoff(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'vco_off_ms', num2str(value(1)), true, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'vco_off_ms', num2str(value(2)), true, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.TxVCOon(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'vco_on_ms', true, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'vco_on_ms', true, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.TxVCOon(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'vco_on_ms', num2str(value(1)), true, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'vco_on_ms', num2str(value(2)), true, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.RxDPoff(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'dp_off_ms', false, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'dp_off_ms', false, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.RxDPoff(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'dp_off_ms', num2str(value(1)), false, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'dp_off_ms', num2str(value(2)), false, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.RxDPon(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'dp_on_ms', false, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'dp_on_ms', false, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.RxDPon(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'dp_on_ms', num2str(value(1)), false, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'dp_on_ms', num2str(value(2)), false, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.RxOff(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'off_ms', false, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'off_ms', false, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.RxOff(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'off_ms', num2str(value(1)), false, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'off_ms', num2str(value(2)), false, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.RxOn(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'on_ms', false, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'on_ms', false, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.RxOn(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'on_ms', num2str(value(1)), false, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'on_ms', num2str(value(2)), false, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.RxVCOoff(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'vco_off_ms', false, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'vco_off_ms', false, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.RxVCOoff(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'vco_off_ms', num2str(value(1)), false, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'vco_off_ms', num2str(value(2)), false, obj.AXICoreTDDDevPtr);
            end
        end
        
        function result = get.RxVCOon(obj)
            result = [0 0];
            if ~isempty(obj.AXICoreTDDDevPtr)
                result(1) = str2double(obj.getAttributeRAW('data0', 'vco_on_ms', false, obj.AXICoreTDDDevPtr));
                result(2) = str2double(obj.getAttributeRAW('data1', 'vco_on_ms', false, obj.AXICoreTDDDevPtr));
            end
        end
        
        function set.RxVCOon(obj, value)
            validateattributes(value, {'double', 'single', 'uint32'}, {'size', [1 2]});
            if obj.ConnectedToDevice
                obj.setAttributeRAW('data0', 'vco_on_ms', num2str(value(1)), false, obj.AXICoreTDDDevPtr);
                obj.setAttributeRAW('data1', 'vco_on_ms', num2str(value(2)), false, obj.AXICoreTDDDevPtr);
            end
        end
    end
    
    methods (Hidden, Access = protected)
        function setupInit(obj)
            numDevs = obj.iio_context_get_devices_count(obj.iioCtx);
            for dn = 1:length(obj.AXICoreTDDDevPtrNames)
                for k = 1:numDevs
                    devPtr = obj.iio_context_get_device(obj.iioCtx, k-1);
                    name = obj.iio_device_get_name(devPtr);
                    if strcmpi(obj.AXICoreTDDDevPtrNames{dn},name)
                        obj.AXICoreTDDDevPtr = devPtr;
                    end
                end
                if isempty(obj.AXICoreTDDDevPtr)
                   error('%s not found',obj.AXICoreTDDDevPtrNames{dn});
                end
            end
        end
    end
end