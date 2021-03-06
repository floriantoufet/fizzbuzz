package fizzbuzz

import (
	"github.com/stretchr/testify/mock"

	"github.com/floriantoufet/fizzbuzz/domains"
)

var _ FizzBuzz = &Mock{}

type Mock struct {
	mock.Mock
}

func (m *Mock) GetMock() *mock.Mock {
	return &m.Mock
}

func (m *Mock) FizzBuzz(request domains.FizzBuzz) (string, error) {
	args := m.Called(request)

	return args.String(0), args.Error(1)
}
