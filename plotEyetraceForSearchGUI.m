function plotEyetraceForSearchGUI(handles, trials, trialSelected)

axes(handles.eyetrace)
hold off
a = plot(trials.tm(trialSelected,:), trials.eyelidpos(trialSelected,:), ...
    'Color', [0 0 1]);
hold on
b = plot([0 0], [0 1], 'Color', [0 0 0], 'LineStyle', ':');
blabel = text(-0.1, 1.025, 'CS on');
isi = trials.c_isi(trialSelected,1)/1000; % convert into s
c = plot([isi isi], [0 1], 'Color', [0 0 0], 'LineStyle', ':');
clabel = text(isi, 1.025, 'US on');
if isfield(trials,'laser') % plot the time that the laser comes on, if it exists
    lasTm = trials.laser.delay(trialSelected, 1)/1000; % convert into s
    d = plot([lasTm lasTm], [0 1], 'Color', [0 0 0], 'LineStyle', ':');
    dlabel = text(lasTm-0.13, 1.025, 'laser on');
end

ylim([0 1])
xlim([-0.2 0.8])

end