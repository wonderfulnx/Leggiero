function transient_analysis(filename, varactor)
% This function plot transient analysis result from ADS
% `filename` file should have three ADS records, including voltage input to
% the varactor, voltage accross the varactor and current going through the
% varactor.
% `varactor` indicates which varactor diode is being used, 0 for SMV2201
% and 1 for MAVR000120.
    %% Read data in
    data = readmatrix(filename);
    len = (size(data, 1) - 2) / 3;
    
    vin = data(1:len, :);
    vdiode = data(len+2:2*len+1, :);
    idiode = data(2*len+3:3*len+2, :);
    clear data
    time = vin(:, 1);
    vin = vin(:, 2);
    vdiode = vdiode(:, 2);
    idiode = idiode(:, 2);
    
    %% Draw varactor model curve
    if varactor == 0
        % this is varactor SMV2201
        varactor_Cjo = 2.097e-12;
        varactor_Vj = 2.984;
        varactor_M = 1.199;
        varactor_Cp = 0.075e-12;
    else
        % this is varactor MAVR000120
        varactor_Cjo = 1.09e-12;
        varactor_Vj = 4.445;
        varactor_M = 2.256;
        varactor_Cp = 0.1394e-12;
    end
    
    varactor_Vr = 0:0.01:12;
    varactor_Cj = varactor_Cjo ./ ((1 + varactor_Vr/varactor_Vj) .^ varactor_M) + varactor_Cp;
    Qj_cal = @(Vr) varactor_Cjo * varactor_Vj ^ varactor_M / (1 - varactor_M) * ...
                  (Vr + varactor_Vj) .^ (1 - varactor_M) + ...
                  varactor_Cp * Vr; % this function is from PN-junction analysis
    varactor_Qj = Qj_cal(varactor_Vr);
    figure
    hold all;
    yyaxis left
    plot(varactor_Vr, varactor_Cj);
    ylabel('Capacitance (F)');
    yyaxis right
    plot(varactor_Vr, varactor_Qj);
    ylabel('Charge (C)');
    xlabel('Reverse Voltage (V)');
    title('Varactor Model: capacitance and charge v.s. Vr');
    legend('Varactor Capacitance', 'Varactor Charge');
    
    %% Calculate charge v.s. time using current integral and initial charge
    q0 = Qj_cal(vdiode(1));
    qdiode = cumtrapz(time, idiode) + q0;
    
    %% Draw measured data
    figure
    subplot(3,1,1);
    plot(time, vdiode); ylabel('Diode voltage (V)');
    title('Voltage, current and charge with time');
    subplot(3,1,2);
    plot(time, idiode); ylabel('Diode current (I)');
    subplot(3,1,3);
    plot(time, qdiode); ylabel('Diode Charge (C)');
    xlabel('Time (s)');
    
    %% Transient charge with voltage Vr
    figure;
    hold all;
    plot(varactor_Vr, varactor_Qj);
    ylabel('Charge (C)');
    xlabel('Reverse Voltage (V)');
    scatter(vdiode, qdiode, [], linspace(1,10,length(vdiode)));
    title('Transient (Qj, Vr) scatter');
    legend('Varactor model charge curve', 'transient Qj,Vr');
    
    %% Transient capacitance calculated
    % no memory effect instantaneous capacitance (ideal)
    cdiode_no_memory = varactor_Cjo ./ ((1 + vin/varactor_Vj) .^ varactor_M) + varactor_Cp;
    % real  instantaneous capacitance calculated with Cj=dQj/dVr
    cdiode = diff(qdiode) ./ diff(vdiode);
    
    % draw capacitance curve
    figure
    hold all;
    plot(time, cdiode_no_memory);
    plot(time(2:end), cdiode);
    title('Capacitance v.s. time');
    xlabel('Time (s)');
    ylabel('Capacitance (F)');
    legend('cap w/o memory', 'cap instantaneous dQ/dV');
end
