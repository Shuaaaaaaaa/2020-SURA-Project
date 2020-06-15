%%
genotype='72F11_GAL4@UAS_Chrimson@t94@r_LED05_45s2x30s30s#n#n#n@100';
timestamp='20180619_123301';
%%
%larva_ind=1;
%view_sec=[45.954 48.113;50.699 51.163;51.979 53.101;59.005 60.224;105.774 112.227;116.495 117.27;120.323 123.477];
%%
larva_ind=9;
view_sec=[45.882 59.652; 105.74 112.703; 117.874 118.325];
%%
% genotype='69F06@UAS_Chrimson@t93@r_LED30_30s2x15s30s#n#n#n@100';
% timestamp='20181201_172530';
% larva_ind=1;
% view_sec=[9.242 9.78;31.255 37.61;38.597 38.89;41.434 45.562;76.428 79.099;79.819 80.818;81.747 82.319;83.44 85.05;87.673 89.124];
%%
% genotype='GMR_SS43207@UAS_Chrimson_attp18@t93@r_LED30_45s2x30s30s#n#n#n@100';
% timestamp='20190327_162301';
% larva_ind=2;
% view_sec=[45.809 47.777;105.537 108.079];

bin=0.5;
window=1;

Diamond_spine_TO(genotype,timestamp,larva_ind,view_sec,window,bin);

% Examine_angles(genotype,timestamp,larva_ind,view_sec);
% Examine_coordinates(genotype,timestamp,larva_ind,view_sec);
% Examine_probabilities(genotype,timestamp,larva_ind,view_sec);
% Examine_spine(genotype,timestamp,larva_ind,view_sec)