classdef ADAR3002Tests < HardwareTests
    
    properties(TestParameter)
       props = {...
           'AmpBiasMuteELV',...
           'AmpBiasOperationalELH',...
           'AmpBiasOperationalELV',...
           'AmpBiasResetELV',...
           'AmpBiasSleepELH',...
           'AmpBiasSleepELV',...
           'AmpENMuteELV',...
           'AmpENOperationalELH',...
           'AmpENOperationalELV',...
           'AmpENResetELV',...
           'AmpENSleepELH',...
           'AmpENSleepELV'
           };
       cprops = {...
           'PhasesBeam0H',...
           'PhasesBeam0V',...
           'PowersBeam0H',...
           'PowersBeam0V',...
           'PhasesBeam1H',...
           'PhasesBeam1V',...
           'PowersBeam1H',...
           'PowersBeam1V',...
           };
    end
    properties
        %         uri = 'ip:10.72.162.61';
        uri = 'ip:10.66.75.19';% uri = 'ip:192.168.86.48';
        author = 'ADI';
    end
    
    methods(TestClassSetup)
        % Check hardware connected
        %         function CheckForHardware(testCase)
        %             Device = @()adi.ADAR3002;
        %             testCase.CheckDevice('ip',Device,testCase.uri(4:end),false);
        %         end
    end
    
    methods (Static)
        function values = clearUnavailable(obj,attrs,values,devices)
            numRows = size(obj.ArrayMapInternal,1);
            numCols = size(obj.ArrayMapInternal,2);
            assert(isequal(size(values),[numRows,numCols]),...
                sprintf('must of size [%dx%d]',numRows,numCols));
            numAttrs = length(attrs);
            for r = 1:numRows
                for c = 1:numCols
                    indx = obj.ArrayMapInternal(r,c);
                    deviceIndx = ceil(indx/numAttrs);
                    attrIndx = mod(indx-1,numAttrs) + 1;
                    
                    %DEBUG
                    if isempty(devices{deviceIndx})
                        values(r,c) = 0;
                    end
                end
            end
            
        end
        
        
        function values = clearUnavailableChannels(obj,channels,values,devices)                        
            tolerance = 0;
            
            % Check dimensions 
            numRows = size(obj.ArrayMapInternal,1);
            numCols = size(obj.ArrayMapInternal,2);
            assert(isequal(size(values),[numRows,numCols]),...
                sprintf('must of size [%dx%d]',numRows,numCols));
            
%             numAttrs = length(channels);
%             numAttrs = length(channels)/length(devices);
            numAttrs = 4;
            for r = 1:numRows
                for c = 1:numCols
                    indx = obj.ArrayMapInternal(r,c);
                    deviceIndx = ceil(indx/numAttrs);
                    attrIndx = mod(indx-1,numAttrs) + 1;
                    
                    %DEBUG
                    if isempty(devices{deviceIndx})
                        values(r,c) = 0;
                        continue;
                    end
                    if isempty(channels{attrIndx})
                        values(r,c) = 0;
                        continue;
                    end   
                end
            end           
        end

    end
    
    methods (Test)
        
        function testADAR3002Smoke(testCase)
            bf = adi.ADAR3002('uri',testCase.uri);
            bf();
            bf.release();
        end
        
        function testADAR3002Single(testCase)
            % Test Reading phases
            bf = adi.ADAR3002('uri',testCase.uri);
            bf();
            values = randi([0,3],1,4);
            bf.PhasesBeam0H = values;
            % Check
            rvalues = getAllRelatedChannelAttrs(bf,...
                'raw',bf.PhasesBeam0HChannelNames,true,bf.iioDevices);
            bf.release();
            testCase.verifyEqual(rvalues,values);
        end
        
        function testADAR3002Array(testCase)
            % Test Reading phases
            bf = adi.ADAR3002Array('uri',testCase.uri);
%             bf = adi.ADAR3002Array('uri',testCase.uri,...
%                 'ArrayMap',[1,2,3,4],...
%                 'deviceNames',{'adar3002_csb_0_0'});
            bf();
            values = randi([0,3],2,4);
            bf.PhasesBeam0H = values;
            % Check
            rvalues = getAllRelatedChannelAttrs(bf,...
                'raw',bf.PhasesBeam0HChannelNames,true,bf.iioDevices);
            bf.release();
            testCase.verifyEqual(rvalues,values);
        end
        
        function testADAR3002LongsPeakChannelAttrs(testCase,cprops)
            % Test Reading channel based attrs
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();
            values = randi([1,3],16,16);
            
            cns = get(bf,[cprops,'ChannelNames']);
            values = testCase.clearUnavailableChannels(bf,...
                cns,values,bf.iioDevices);
            set(bf,cprops,values);

            % Check
            cn = get(bf,[cprops,'ChannelNames']);
            rvalues = getAllRelatedChannelAttrs(bf,...
                'raw',cn,true,bf.iioDevices);
            
            bf.release();
            testCase.verifyEqual(rvalues,values);
        end
        
        function testADAR3002LongsPeakDevAttrs(testCase,props)
            % Test Reading phases
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();
            values = randi([0,3],16,16);
            
            p = get(bf,[props,'Attrs']);

            values = testCase.clearUnavailable(bf,...
                p,values,bf.iioDevices);
            
            set(bf,props,values);

            % Check
            rvalues = getAllRelatedDevAttrs(bf,...
                p,bf.iioDevices);
            bf.release();
            
            testCase.verifyEqual(rvalues,values);
        end
        
        function testADAR3002LongsPeakDevAttrsCTRL(testCase)
            % Test Reading update_intf_ctrl
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();
            values = randi([1,2],1,64);r = {'spi','pin'};
            values = r(values);
            
            bf.UpdateIntfCtrl = values;
            % Check
            rvalues = cell(1,64);
            for k=1:64
                if ~isempty(bf.iioDevices{k})
                    rvalues{k} = bf.getDeviceAttributeRAW('update_intf_ctrl',...
                        64,bf.iioDevices{k});
                end
            end
            bf.release();
            
            for di = 1:length(bf.iioDevices)
               if ~isempty(bf.iioDevices{di})
                   testCase.verifyEqual(rvalues{di},values{di});
               end
            end
        end

        function testADAR3002LongsPeakDownCnvLOFreqHz(testCase)
            % Test Down Converter LO Frequency
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();

            values = round((1+1./randi([2 6], [1 2]))*1e10);
            bf.LOFreqHz = values;
            % Check
            rvalues = zeros(1,2);
            for k=1:2
                if ~isempty(bf.downCnvDevices{k})
                    rvalues(k) = bf.getDeviceAttributeLongLong('lo_freq_hz',...
                        bf.downCnvDevices{k});
                end
            end
            bf.release();

            for di = 1:length(bf.downCnvDevices)
               if ~isempty(bf.downCnvDevices{di})
                   testCase.verifyEqual(rvalues(di),values(di));
               end
            end
        end

        function testADAR3002LongsPeakDownCnvMuxSel(testCase)
            % Test Down Converter MUX Select
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();

            values = randi([0 4], [1 2]);
            bf.MuxSel = values;
            % Check
            rvalues = zeros(1,2);
            for k=1:2
                if ~isempty(bf.downCnvDevices{k})
                    tmp = getDeviceAttributeRAW(bf,'mux_sel',128,bf.downCnvDevices{k});
                    if strcmp('LOW',tmp)
                        rvalues(:,k) = 0;
                    elseif strcmp('LOCK_DTCT',tmp)
                        rvalues(:,k) = 1;
                    elseif strcmp('R_COUNTER_PER_2',tmp)
                        rvalues(:,k) = 2;
                    elseif strcmp('N_COUNTER_PER_2',tmp)
                        rvalues(:,k) = 3;
                    elseif strcmp('HIGH',tmp)
                        rvalues(:,k) = 4;
                    end
                end
            end
            bf.release();

            for di = 1:length(bf.downCnvDevices)
               if ~isempty(bf.downCnvDevices{di})
                   testCase.verifyEqual(rvalues(di),values(di));
               end
            end
        end

        function testADAR3002LongsPeakDownCnvNCounterFracVal(testCase)
            % Test Down Converter LO Frequency
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();

            values = randi([0 5], [1 2]);
            bf.NCounterFracVal = values;
            % Check
            rvalues = zeros(1,2);
            for k=1:2
                if ~isempty(bf.downCnvDevices{k})
                    rvalues(k) = bf.getDeviceAttributeLongLong('n_counter_frac_val',...
                        bf.downCnvDevices{k});
                end
            end
            bf.release();

            for di = 1:length(bf.downCnvDevices)
               if ~isempty(bf.downCnvDevices{di})
                   testCase.verifyEqual(rvalues(di),values(di));
               end
            end
        end
        
        function testADAR3002LongsPeakDownCnvNCounterIntVal(testCase)
            % Test Down Converter LO Frequency
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();

            values = randi([0 5], [1 2]);
            bf.NCounterIntVal = values;
            % Check
            rvalues = zeros(1,2);
            for k=1:2
                if ~isempty(bf.downCnvDevices{k})
                    rvalues(k) = bf.getDeviceAttributeLongLong('n_counter_int_val',...
                        bf.downCnvDevices{k});
                end
            end
            bf.release();

            for di = 1:length(bf.downCnvDevices)
               if ~isempty(bf.downCnvDevices{di})
                   testCase.verifyEqual(rvalues(di),values(di));
               end
            end
        end

        function testADAR3002LongsPeakDownCnvNCounterModVal(testCase)
            % Test Down Converter LO Frequency
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();

            values = randi([0 5], [1 2]);
            bf.NCounterModVal = values;
            % Check
            rvalues = zeros(1,2);
            for k=1:2
                if ~isempty(bf.downCnvDevices{k})
                    rvalues(k) = bf.getDeviceAttributeLongLong('n_counter_mod_val',...
                        bf.downCnvDevices{k});
                end
            end
            bf.release();

            for di = 1:length(bf.downCnvDevices)
               if ~isempty(bf.downCnvDevices{di})
                   testCase.verifyEqual(rvalues(di),values(di));
               end
            end
        end

        function testADAR3002LongsPeakDownCnvPFDFreqHz(testCase)
            % Test Down Converter LO Frequency
            bf = adi.LongsPeak('uri',testCase.uri);
            bf();

            values = randi([2 6], [1 2])*1e7;
            bf.PFDFreqHz = values;
            % Check
            rvalues = zeros(1,2);
            for k=1:2
                if ~isempty(bf.downCnvDevices{k})
                    rvalues(k) = bf.getDeviceAttributeLongLong('pfd_freq_hz',...
                        bf.downCnvDevices{k});
                end
            end
            bf.release();

            for di = 1:length(bf.downCnvDevices)
               if ~isempty(bf.downCnvDevices{di})
                   testCase.verifyEqual(rvalues(di),values(di));
               end
            end
        end
    end
    
end

