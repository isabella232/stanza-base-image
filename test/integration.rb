describe package('systemd') do
    it { should be_installed }
    its('version') { should eq '245.4-4ubuntu3.7' }
end

describe package('tzdata') do
    it { should be_installed }
    its('version') { should eq '2021a-0ubuntu0.20.04' }
end

describe package('ca-certificates') do
    it { should be_installed }
    its('version') { should eq '20210119~20.04.1' }
end

