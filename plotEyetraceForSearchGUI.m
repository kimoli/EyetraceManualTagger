function plotEyetraceForSearchGUI(handles, trials, trialSelected)

ymax = str2double(get(handles.ymaxEditTextbox, 'String'));
ymin = str2double(get(handles.ylimEditTextbox, 'String'));
xmax = str2double(get(handles.xmaxEditTextbox, 'String'));
xmin = str2double(get(handles.xlimEditTextbox, 'String'));

axes(handles.eyetrace)
hold off
a = plot(trials.tm(trialSelected,:), trials.eyelidpos(trialSelected,:), ...
    'Color', [0 0 1]);
hold on
b = plot([0 0], [ymin ymax], 'Color', [0 0 0], 'LineStyle', ':');
blabel = text(0, ymax*1.025, 'CS on', 'HorizontalAlignment', 'right');
isi = trials.c_isi(trialSelected,1)/1000; % convert into s
c = plot([isi isi], [ymin ymax], 'Color', [0 0 0], 'LineStyle', ':');
clabel = text(isi, ymax*1.025, 'US on');
if isfield(trials,'laser') % plot the time that the laser comes on, if the field exists and the laser comes on
    if trials.laser.amp(trialSelected,1)>0 && trials.laser.dur(trialSelected,1)>0
        lasTm = trials.laser.delay(trialSelected, 1)/1000; % convert into s
        d = plot([lasTm lasTm], [ymin ymax], 'Color', [0 0 0], 'LineStyle', ':');
        dlabel = text(lasTm, ymax*1.06, 'laser on', 'HorizontalAlignment', 'right');
    end
end

ylim([ymin ymax])
xlim([xmin xmax])

end